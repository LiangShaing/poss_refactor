import 'dart:math';

import 'package:chowsangsang_enterprise_portal/service_factory.dart' hide Employee;
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_amount.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_info.dart';
import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';
import 'package:mobile_poss_gp01/events/product_amount_event.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/repositories/customer_session_repository.dart';
import 'package:mobile_poss_gp01/repositories/product_repository.dart';
import 'package:mobile_poss_gp01/states/product_amount_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';

class ProductAmountBloc extends AbstractBloc<ProductAmountEvent, ProductAmountState> {
  final ProductRepository productRepository;
  final AuthenticationRepository authenticationRepository;
  final CustomerSessionRepository customerSessionRepository;

  ProductAmountBloc(
      {required this.authenticationRepository,
      required this.productRepository,
      required this.customerSessionRepository})
      : super(ProductAmountLoadInitial()) {
    on<ProductAmountFetched>(_amountFetched);
  }

  Future<void> _amountFetched(ProductAmountFetched event, Emitter<ProductAmountState> emit) async {
    emit(ProductAmountLoadInProgress());
    ProductInfo productInfo = event.productInfo;
    //取得金額
    try {
      ProductAmount productAmount = await getStoreProductAmount(productInfo);
      emit(ProductAmountLoadSuccess(productAmount));
    } catch (e) {
      Logger.error(className: "ProductAmountBloc", event: "_amountFetched", message: e.toString());
      emit(ProductAmountLoadFailure("取得金額失敗", exception: e));
    }
  }

  Future<ProductAmount> getStoreProductAmount(ProductInfo productInfo) async {
    /* 預設定價貨品 */
    double inventoryAmount = productInfo.price ?? 0;
    double netAmount = 0;
    double? goldPrice = 0;
    try {
      /* 貨牌價 */
      /* 計價貨品 */
      if (!(productInfo.fixedPriceIndicator)) {
        Logger.debug(message: 'not fixed price item, then get gold price');

        /* 先取得金價去算貨牌價 */
        // TODO action目前寫死為'SELL'
        String action = 'SELL';
        String pricingType = productInfo.pricingType ?? "";
        String declareMaterial = productInfo.declareMaterial ?? '';
        String usage = productInfo.usage ?? '';
        String goldType = productInfo.goldType ?? '';

        /* 從api取得金價 */
        PossGoldPriceRes? possGoldPriceRes = await productRepository.getGoldPrice(
          [action],
          [pricingType],
          [declareMaterial],
          [usage],
          [goldType],
        );
        PossGoldPriceResult? possGoldPriceResult = possGoldPriceRes.results.firstOrNull;

        goldPrice = possGoldPriceResult?.price.toDouble();
        double gram = productInfo.bookingUnit?.grossWeightGram ?? 0;
        /* 計價商品工費 取inventory price */
        double laborCost = productInfo.bookingUnit?.laborCost?.toDouble() ?? 0;

        if (goldPrice != null) {
          /* 計價商品貨牌價 = 金重(grossWeight) * 金價(goldPrice) + 工費(laborCost) */
          inventoryAmount = (gram * goldPrice + laborCost).floorToDouble();
        } else {
          throw IllegalArgumentException(
              "getStoreProductAmount failed _goldPrice[$goldPrice], _grossWeightGram[$gram]");
        }
        Logger.debug(message: '${productInfo.inventoryId} inventoryAmount $inventoryAmount');
      }

      /* 約定售價 從api取得 */
      String? inventoryId = productInfo.inventoryId;
      /* 如果是inventory商品則不帶modelSequenceNumber */
      int? modelSequenceNumber = inventoryId != null ? null : productInfo.modelSequenceNumber?.toInt();
      Employee employee = await authenticationRepository.getEmployee();

      customerSessionRepository.currentCustomerSession(employee);

      final String? customerId = customerSessionRepository.currentCustomerSession(employee)?.customerId;
      PossProductDiscountCalculateRes? possInventorySingleDiscounts = await productRepository
          .postProductDiscountCalculate(customerId: customerId, products: [
        PossProductDiscountCalculateReqProduct(inventoryId: inventoryId, modelSequenceNumber: modelSequenceNumber)
      ]);

      PossSingleDiscountResult? singleDiscountResult = possInventorySingleDiscounts.singleDiscountResults.firstOrNull;
      List<PossSingleDiscount> discounts =
          singleDiscountResult?.discounts.where((e) => e.projectLineId != null).toList() ?? [];
      PossSingleDiscount? selectedDiscount = discounts.firstOrNull;
      if (discounts.isNotEmpty) {
        Logger.debug(
            message:
                'got discounts from getSingleDiscounts response, length:${singleDiscountResult?.discounts.length}');
        netAmount = discounts.map((e) => e.agreePrice).reduce(min).toDouble();
        Logger.debug(message: 'found minimum price from discounts $netAmount');
        selectedDiscount = discounts.firstWhere((e) => e.agreePrice == netAmount);
        Logger.debug(message: 'found discount code of minimum price ${selectedDiscount.projectLineId}');
      } else {
        Logger.debug(message: 'got empty discounts from getSingleDiscounts response');
        netAmount = inventoryAmount.floorToDouble();
      }

      return ProductAmount(inventoryAmount, netAmount, selectedDiscount, discounts, goldPrice);
    } catch (e) {
      Logger.error(message: "get product item net amount failed");
      rethrow;
    }
  }
}
