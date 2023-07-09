import 'dart:math';

import 'package:chowsangsang_enterprise_portal/service_factory.dart' hide Employee;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_amount.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_info.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/store_product.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';
import 'package:mobile_poss_gp01/enum/sale_type.dart';
import 'package:mobile_poss_gp01/events/product_event.dart';
import 'package:mobile_poss_gp01/events/shopping_bag_event.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/repositories/customer_session_repository.dart';
import 'package:mobile_poss_gp01/repositories/product_repository.dart';
import 'package:mobile_poss_gp01/resources/static_values.dart';
import 'package:mobile_poss_gp01/states/product_state.dart';
import 'package:mobile_poss_gp01/states/shopping_bag_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:realm/realm.dart';

class ShoppingBagBloc extends AbstractBloc<ShoppingBagEvent, ShoppingBagState> {
  // final ProductRepository productRepository;
  final AuthenticationRepository authenticationRepository;
  final CustomerSessionRepository customerSessionRepository;

  ShoppingBagBloc(
      {required this.authenticationRepository,
      // required this.productRepository,
      required this.customerSessionRepository})
      : super(ShoppingBagLoadInitial()) {
    on<ShoppingBagItemAdded>(_addToCartItem);
  }

  Future<void> _addToCartItem(ShoppingBagItemAdded event, Emitter<ShoppingBagState> emit) async {
    emit(ShoppingBagItemAddInProgress());
    try {
      final ProductInfo? productInfo = event.productInfo;
      // final ProductItemO2OPOJO? productItemO2OPOJO = event.productItemO2OPOJO;
      final ProductAmount productAmount = event.productAmount;

      // if (!pojo.isInventoryItem && !pojo.isModelItem) {
      //   throw IllegalArgumentException("addToCartItem product type is empty");
      // }
      //
      // if (pojo.isInventoryItem && pojo.isModelItem) {
      //   throw IllegalArgumentException("addToCartItem product type error");
      // }

      // String? inventoryId;
      // double? laborCost;
      // double? modelSequenceNumber;
      // String? itemNumber;
      // String? catalogItem;
      //
      // String? brand;
      // String? collection;
      // String? subCollection;
      // bool? fixedPriceIndicator;
      // double? grossWeight;
      // List<String> imagesPath = [];
      // String saleType = SaleType.inStore.value;
      // double? physicalWeightGram;
      // double? caratWeight;
      // String? color;
      // String? clarity;
      // String? cutGrade;
      // String? productName;
      // String? usageReferenceCode;
      // String? sizeAndLength;
      //
      // if (productItemO2OPOJO != null) {
      //   /* 遙距倉 */
      //   PossProductBookingUnit unit = productItemO2OPOJO.possProductBookingUnit;
      //   inventoryId = unit.cbu.inventoryId;
      //   fixedPriceIndicator = productItemO2OPOJO.fixedPriceIndicator;
      //   /* 計價商品工費 取inventory price */
      //   laborCost = (fixedPriceIndicator ?? true) ? unit.laborCost : unit.price;
      //   modelSequenceNumber = unit.cbu.modelSequenceNumber?.toDouble();
      //   itemNumber = unit.itemNumber;
      //   catalogItem = productItemO2OPOJO.catalogItemCode;
      //
      //   productName = [
      //     productItemO2OPOJO.goldTypeDescription ?? "",
      //     productItemO2OPOJO.materialCategoryDescription ?? "",
      //     productItemO2OPOJO.usageDescription ?? "",
      //   ].where((e) => e.isNotEmpty).join(" ");
      //
      //   brand = productItemO2OPOJO.brand;
      //   collection = productItemO2OPOJO.collection;
      //   subCollection = productItemO2OPOJO.subCollection;
      //
      //   grossWeight = unit.grossWeightGram;
      //   saleType = SaleType.remoted.value;
      //   imagesPath = pojo.imagesPath;
      //   physicalWeightGram = unit.physicalWeightGram;
      //   caratWeight = unit.caratWeight;
      //   color = unit.color;
      //   clarity = unit.clarity;
      //   cutGrade = unit.cutGrade;
      //   sizeAndLength = unit.size;
      //   usageReferenceCode = productItemO2OPOJO.usageCode;
      //   sizeAndLength = _getProductSizeAndLength(
      //       usageReferenceCode ?? "", unit.size ?? "", unit.size ?? "", productItemO2OPOJO.earingTypeDescription ?? "");
      // } else if (productInfoRes != null) {
      //   /* 本店 */
      //   inventoryId = productInfoRes.inventory!.inventoryId;
      //   fixedPriceIndicator = productInfoRes.model?.fixedPriceIndicator;
      //   /* 計價商品工費 取inventory price */
      //   laborCost =
      //       (fixedPriceIndicator ?? true) ? productInfoRes.inventory?.laborCost : productInfoRes.inventory?.price;
      //   modelSequenceNumber = productInfoRes.model?.modelSequenceNumber;
      //   itemNumber = productInfoRes.inventory?.itemNumber;
      //   catalogItem = productInfoRes.catalogItem?.catalogItem;
      //
      //   //TODO: 先註解從staticReferenceExt取名稱
      //   productName = [
      //     productInfoRes.catalogItem?.goldType?.zhCN ?? "",
      //     productInfoRes.catalogItem?.materialCategory?.zhCN ?? "",
      //     productInfoRes.catalogItem?.usage?.zhCN ?? ""
      //   ].where((e) => e.isNotEmpty).join(" ");
      //   // productName = IndexPageState.prodService
      //   //     .getStoreProductName(productInfoRes.catalogItem!)
      //   //     .where((e) => e.isNotEmpty)
      //   //     .join(" ");
      //
      //   brand = productInfoRes.catalogItem?.brand?.zhCN;
      //   collection = productInfoRes.catalogItem?.collection?.zhCN;
      //   subCollection = productInfoRes.catalogItem?.subCollection?.zhCN;
      //   grossWeight = productInfoRes.inventory?.grossWeight?.gram;
      //   physicalWeightGram = productInfoRes.inventory?.physicalWeight?.gram;
      //   Bom? bom = productInfoRes.inventory?.bom.firstWhereOrNull((e) => e.mainMaterialIndicator);
      //   caratWeight = bom?.caratWeight;
      //   color = bom?.diamondColor?.zhCN;
      //   clarity = bom?.diamondClarity?.referenceCode;
      //   cutGrade = bom?.diamondCutGrade?.zhCN;
      //   usageReferenceCode = productInfoRes.catalogItem?.usage?.referenceCode;
      //
      //   sizeAndLength = _getProductSizeAndLength(
      //       usageReferenceCode ?? "",
      //       productInfoRes.model?.length?.referenceCode ?? "",
      //       productInfoRes.model?.ringSize?.referenceCode ?? "",
      //       productInfoRes.catalogItem?.earringsType.firstOrNull?.zhCN ?? "");
      // }

      // /* Earmark 鎖定貨品 */
      // if (inventoryId != null) {
      //   await apiService.postInventoryEarmark(inventoryId);
      // }
      // CustomerSession? _customerSession = realmService.currentCustomerSessionQuery?.firstOrNull;
      Employee employee = await authenticationRepository.getEmployee();

      CustomerSession? currentCustomerSession = customerSessionRepository.currentCustomerSession(employee);
      if (currentCustomerSession == null) {
        emit(const ShoppingBagItemAddFailure("請先產生會客序號"));
        return;
      }

      ShoppingBag? shoppingBag = currentCustomerSession.shoppingBag;
      PossSingleDiscount? selectedDiscount = productAmount.selectedDiscount;
      DateTime now = DateTime.now().toUtc();

      /* 購物車商品 */
      ShoppingBagItem shoppingBagItem = ShoppingBagItem(ObjectId(), now,
          ctLineNumber: await _createCTLineNumber(),
          inventoryId: productInfo?.inventoryId,
          inventoryAmount: productAmount.inventoryAmount,
          modelSequenceNumber: productInfo?.modelSequenceNumber,
          quantity: 1,
          saleType: productInfo?.saleType,
          netAmount: productAmount.netAmount,
          laborCost: productInfo?.bookingUnit?.laborCost?.toDouble(),
          discountName: selectedDiscount?.discountName,
          selectedDiscountProjectLineId: selectedDiscount?.projectLineId);

      /* CacheProductItems */
      // List<ProductDiscount> discounts = productAmount.discounts
      //     .where((e) => e.projectLineId != null)
      //     .map((e) => ProductDiscount(e.projectLineId ?? "", e.discountName ?? "", e.agreePrice))
      //     .toList();
      // CacheProductItem cache = CacheProductItem(shoppingBagItem.id, now,
      //     modelSequenceNumber: productInfo?.modelSequenceNumber,
      //     inventoryId: productInfo?.inventoryId,
      //     itemNumber: productInfo?.itemNumber,
      //     catalogItemCode: productInfo?.catalogItemCode,
      //     netAmount: productAmount.netAmount,
      //     inventoryAmount: productAmount.inventoryAmount,
      //     discounts: discounts,
      //     selectedProductDiscount: ProductDiscount(
      //       selectedDiscount?.projectLineId ?? "",
      //       selectedDiscount?.discountName ?? "",
      //       selectedDiscount?.agreePrice ?? 0,
      //     ),
      //     saleType: productInfo?.saleType,
      //     brand: CatalogItemTitle(name: brand),
      //     collection: CatalogItemTitle(name: collection),
      //     subCollection: CatalogItemTitle(name: subCollection),
      //     goldPrice: productAmount.goldPrice,
      //     fixedPriceIndicator: productInfo?.fixedPriceIndicator,
      //     bookingUnitInfo: BookingUnit(
      //         cbu: BookingUnitsCbu(inventoryId: inventoryId),
      //         modelSequenceNumber: modelSequenceNumber,
      //         laborCost: laborCost,
      //         grossWeightGram: grossWeight,
      //         physicalWeightGram: physicalWeightGram,
      //         caratWeight: caratWeight,
      //         color: color,
      //         clarity: clarity,
      //         cutGrade: cutGrade,
      //         usageReferenceCode: usageReferenceCode,
      //         sizeAndLength: sizeAndLength),
      //     imagesPath: imagesPath,
      //     productName: productName);
      // cacheProductItem(cache);

      /* 新增商品至 BrowsingHistories */
      customerSessionRepository.createBrowsingHistories(
          currentCustomerSession,
          BrowsingHistories(now,
              modelSequenceNumber: productInfo?.modelSequenceNumber,
              inventoryId: productInfo?.inventoryId,
              saleType: SaleType.inStore.value));

      if (shoppingBag?.ctId == null) {
        /* 新增商品至 realm shopping cart */
        customerSessionRepository.addItemToShoppingBag(currentCustomerSession, shoppingBagItem);
        emit(const ShoppingBagItemAddSuccess());
        // realmService.realm.write(() {
        //   if (shoppingBag == null) {
        //     _customerSession?.shoppingBag = ShoppingBag(ObjectId(), now,
        //         departmentCode: realmService.possEmployees?.defaultDepartmentCode, items: [_shoppingBagItem]);
        //   } else {
        //     shoppingBag.items.add(shoppingBagItem);
        //   }
        // });
      } else {
        // Logger.debug(message: "CartServiceImpl addCartItemByStore with shoppingBag.ctId");
        // /* CT已成立 */
        // Logger.debug(
        //     message: "CartServiceImpl addCartItemByStore discount.projectLineId [${_selectedDiscount?.projectLineId}]");
        //
        // CacheProductItem? cacheProductItem =
        //     findCacheProductItem(inventoryId, inventoryId != null ? null : modelSequenceNumber);
        // String productOption = IndexPageState.prodService.getProductDescription(cacheProductItem).join('');
        //
        // PossCustomerTransactionPostReqItem newOne = PossCustomerTransactionPostReqItem(
        //   productOption: productOption,
        //   lineNumber: _shoppingBagItem.ctLineNumber ?? createCTLineNumber(),
        //   inventoryId: inventoryId,
        //   singleDiscountInformation:
        //       (_selectedDiscount?.projectLineId != null && _selectedDiscount?.discountName != null)
        //           ? PossSingleDiscountInformation(
        //               projectLineId: _selectedDiscount?.projectLineId,
        //               discountName: _selectedDiscount?.discountName,
        //             )
        //           : null,
        //   agreePrice: productAmountPOJO.netAmount!,
        //   agreeLaborCharge: laborCost,
        //   quantity: 1,
        //   saleType: saleType,
        //   modelSequenceNumber: inventoryId != null ? null : modelSequenceNumber?.toInt(),
        // );
        //
        // PossCustomerTransactionRes _possCustomerTransactionRes = await apiService.postCustomerTransactionLines(
        //     ctId: _shoppingBag!.ctId!, items: [newOne], customerId: _customerSession?.customerId);
        // /* 將ct結果存回realm 如果是已有CT post new one 成功直接加入購物車不從response異動*/
        // updateShoppingBagFromCt(_possCustomerTransactionRes);
      }
    } catch (e) {
      Logger.error(className: "ShoppingBagBloc", event: "_addToCartItem", message: e.toString());
      String message = "";
      if (e is BadRequestException) {
        message = e.message;
      }
      emit(ShoppingBagItemAddFailure(message, exception: e));
    }
  }

  Future<int> _createCTLineNumber() async {
    Employee employee = await authenticationRepository.getEmployee();
    CustomerSession? currentCustomerSession = customerSessionRepository.currentCustomerSession(employee);
    List<ShoppingBagItem> shoppingBagItems = currentCustomerSession?.shoppingBag?.items ?? [];
    return (shoppingBagItems.isNotEmpty ? (shoppingBagItems.map((e) => (e.ctLineNumber ?? 0)).reduce(max)) : 0) + 1;
  }
}
