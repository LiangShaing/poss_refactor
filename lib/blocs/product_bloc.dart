import 'dart:math';

import 'package:chowsangsang_enterprise_portal/service_factory.dart' hide Employee;
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_amount.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_info.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/store_product.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';
import 'package:mobile_poss_gp01/enum/sale_type.dart';
import 'package:mobile_poss_gp01/events/product_event.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/repositories/customer_session_repository.dart';
import 'package:mobile_poss_gp01/repositories/product_repository.dart';
import 'package:mobile_poss_gp01/resources/static_values.dart';
import 'package:mobile_poss_gp01/services/product/product_service.dart';
import 'package:mobile_poss_gp01/states/product_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:realm/realm.dart';

class ProductBloc extends AbstractBloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  final AuthenticationRepository authenticationRepository;
  final CustomerSessionRepository customerSessionRepository;

  ProductBloc(
      {required this.authenticationRepository,
      required this.productRepository,
      required this.customerSessionRepository})
      : super(ProductLoadInitial()) {
    on<ProductItemFetched>(_itemFetched);
  }

  Future<void> _itemFetched(ProductItemFetched event, Emitter<ProductState> emit) async {
    emit(ProductLoadInProgress());
    String searchText = event.value;
    bool isCatalogItemCode = StaticValues.catalogItemCodeRegexp.hasMatch(event.value);
    String catalogItemCode;
    Earmark? earmark;

    StoreProduct storeProduct;
    Employee employee = await authenticationRepository.getEmployee();
    ;
    /* 如果小於8碼不搜尋*/
    if (searchText.length < 8) {
      Logger.debug(message: "ProductBloc _itemFetched searchText.length < 8");
      emit(const ProductLoadFailure("輸入內容不得小於8碼"));
    }

    if (customerSessionRepository.currentCustomerSession(employee) == null) {
      Logger.debug(message: "ProductBloc currentCustomerSession is empty");
      emit(ProductLoadFailure("widget.showAddToCartDialog.message.createdCustomerSession".tr));
      return;
    }

    if (isCatalogItemCode) {
      catalogItemCode = searchText;
      /* catalogItem */
      Logger.info(
          className: "ProductBloc", event: "_itemFetched", message: "search text $searchText is catalogItemCode");
      earmark = productRepository.findEarmarkByCatalogItem(searchText);

      if (earmark == null) {
        throw RealmException("findProductBySearchText productItem not found in earmark");
      } else {
        Logger.info(message: "found productItem in earmark $earmark");
        storeProduct = StoreProduct(earmark: earmark);
      }
    } else {
      /* inventoryId or itemNumber */
      Logger.info(message: "search text $searchText is inventoryId or itemNumber");
      storeProduct = productRepository.getProductItemByItemNumberOrInventoryId(searchText, employee);

      if (!storeProduct.isInStore && storeProduct.earmark == null) {
        /* 不在本店也不在earmark */
        throw RealmException("findProductBySearchText productItem not found");
      }
      catalogItemCode = storeProduct.inventory!.catalogItem!;
    }

    /* 本店catalogItem商品 */
    List<StoreProduct> storeCatalogItems =
        productRepository.getProductItemFromStoreByCatalogItem(catalogItemCode, employee);
    storeProduct.storeCatalogItems = storeCatalogItems;

    if (storeProduct.isInStore) {
      Logger.debug(message: "ProductStoreLoadSuccess");
      ProductInfo productInfo = _processProductDataFromStore(storeProduct);
      emit(ProductStoreLoadSuccess(productInfo));
      // //取得金額
      // try {
      //   ProductAmount productAmount = await getStoreProductAmount(storeProduct);
      //   emit(ProductStoreLoadSuccess(productInfo, productAmount: productAmount));
      // } catch (e) {}
    } else {
      Logger.debug(message: "ProductRemotedLoadSuccess");
      emit(ProductRemotedLoadSuccess());
    }
  }

  ProductInfo _processProductDataFromStore(StoreProduct storeProduct) {
    ProductService productService = ProductService();
    CatalogItem? catalogItem = storeProduct.catalogItem;
    Model? model = storeProduct.model;
    Inventory? inventory = storeProduct.inventory;

    String pricingType = catalogItem?.pricingType ?? "";
    String declareMaterial = catalogItem?.declaredMaterial?.referenceCode ?? '';
    String usage = model?.usage?.referenceCode ?? '';
    String goldType = catalogItem?.goldType?.referenceCode ?? '';

    String? inventoryId = inventory!.inventoryId;
    bool? fixedPriceIndicator = model?.fixedPriceIndicator;
    /* 計價商品工費 取inventory price */
    int? laborCost = (fixedPriceIndicator ?? true) ? inventory.laborCost.round() : inventory.price.round();
    double? modelSequenceNumber = model?.modelSequenceNumber;
    String? itemNumber = inventory.itemNumber;
    String? catalogItemCode = catalogItem?.catalogItem;
    double? price = inventory.price;
    String brand = catalogItem?.brand?.zhCN ?? "";
    String collection = catalogItem?.collection?.zhCN ?? "";
    String subCollection = catalogItem?.subCollection?.zhCN ?? "";

    double? grossWeight = inventory.grossWeight?.gram;
    List<String> imagesPath = [];
    String saleType = SaleType.inStore.value;
    double? physicalWeightGram = inventory.physicalWeight?.gram;
    // double? caratWeight;
    // String? color;
    // String? clarity;
    // String? cutGrade;
    String? usageReferenceCode = catalogItem?.usage?.referenceCode;
    String? sizeAndLength = productService.getProductSizeAndLength(
        usageReferenceCode ?? "",
        model?.length?.referenceCode ?? "",
        model?.ringSize?.referenceCode ?? "",
        catalogItem?.earringsType.firstOrNull?.zhCN ?? "");

    //TODO: 先註解從staticReferenceExt取名稱
    String? productName = [
      catalogItem?.goldType?.zhCN ?? "",
      catalogItem?.materialCategory?.zhCN ?? "",
      catalogItem?.usage?.zhCN ?? ""
    ].where((e) => e.isNotEmpty).join(" ");
    // productName = IndexPageState.prodService
    //     .getStoreProductName(productInfoRes.catalogItem!)
    //     .where((e) => e.isNotEmpty)
    //     .join(" ");

    List<ProductBom> productBomList = inventory.bom
        .where((e) => e.mainMaterialIndicator)
        .map((e) => ProductBom(
            caratWeight: e.caratWeight,
            color: e.diamondColor?.zhCN,
            clarity: e.diamondClarity?.referenceCode,
            cutGrade: e.diamondCutGrade?.zhCN,
            bomCertificates: e.bomCertificates
                .map((s) => ProductBomCertificate(
                    physicalCertificateIndicator: s.physicalCertificateIndicator ?? "",
                    certificateOrganization: s.certificateOrganization ?? "",
                    certificateNumber: s.certificateNumber ?? "",
                    reportPdfPath: s.reportPdfPath,
                    digitalCardPath: s.digitalCardPath))
                .toList()))
        .toList();
    // caratWeight = bom?.caratWeight;
    // color = bom?.diamondColor?.zhCN;
    // clarity = bom?.diamondClarity?.referenceCode;
    // cutGrade = bom?.diamondCutGrade?.zhCN;

    String? finalBrandCollection;
    String? finalCollection;

    if (brand.isNotEmpty) {
      finalBrandCollection = brand;
    } else if (brand.isEmpty && collection.isNotEmpty) {
      finalBrandCollection = collection;
    }

    if (finalBrandCollection == collection) {
      finalCollection = subCollection;
    } else {
      if (collection.isNotEmpty) {
        finalCollection = collection;
      } else if (collection.isEmpty && subCollection.isNotEmpty) {
        finalCollection = subCollection;
      }
    }

    /* 重量下限 找CN用的 weightUnit = GM */
    double? physicalWeightLowerBound =
        catalogItem?.standardSpecificationPhysicalWeight.firstWhereOrNull((e) => e.weightUnit == "GM")?.lowerBound;

    ProductInfo info = ProductInfo(
        catalogItemCode: catalogItemCode,
        productName: productName,
        finalBrandCollection: finalBrandCollection,
        finalCollection: finalCollection,
        fixedPriceIndicator: fixedPriceIndicator!,
        modelSequenceNumber: modelSequenceNumber,
        inventoryId: inventoryId,
        itemNumber: itemNumber,
        usageCode: usageReferenceCode,
        // netAmount: productAmountPOJO.netAmount,
        // inventoryAmount: productAmountPOJO.inventoryAmount,
        // discounts: _discounts,
        // selectedProductDiscount: ProductDiscount(
        //   _selectedDiscount?.projectLineId ?? "",
        //   _selectedDiscount?.discountName ?? "",
        //   _selectedDiscount?.agreePrice ?? 0,
        // ),
        saleType: saleType,
        // goldPrice: productAmountPOJO.goldPrice,
        price: price,
        bookingUnit: ProductBookingUnit(
            cbu: ProductCbu(inventoryId: inventoryId),
            modelSequenceNumber: modelSequenceNumber,
            laborCost: laborCost,
            grossWeightGram: grossWeight,
            physicalWeightGram: physicalWeightGram,
            // caratWeight: caratWeight,
            // color: color,
            // clarity: clarity,
            // cutGrade: cutGrade,
            size: sizeAndLength,
            physicalWeightLowerBound: physicalWeightLowerBound,
            bom: productBomList),
        pricingType: pricingType,
        declareMaterial: declareMaterial,
        usage: usage,
        goldType: goldType
        // imagesPath: imagesPath,
        );

    return info;
  }

// Future<ProductAmount> getStoreProductAmount(StoreProduct storeProduct) async {
//   /* 預設定價貨品 */
//   double inventoryAmount = storeProduct.inventory?.price ?? 0;
//   double netAmount = 0;
//   double? goldPrice = 0;
//   try {
//     /* 貨牌價 */
//     /* 計價貨品 */
//     if (!(storeProduct.model?.fixedPriceIndicator ?? true)) {
//       Logger.debug(message: 'not fixed price item, then get gold price');
//
//       /* 先取得金價去算貨牌價 */
//       // TODO action目前寫死為'SELL'
//       String action = 'SELL';
//       String pricingType = storeProduct.catalogItem?.pricingType ?? "";
//       String declareMaterial = storeProduct.catalogItem?.declaredMaterial?.referenceCode ?? '';
//       String usage = storeProduct.model?.usage?.referenceCode ?? '';
//       String goldType = storeProduct.catalogItem?.goldType?.referenceCode ?? '';
//
//       /* 從api取得金價 */
//       PossGoldPriceRes? possGoldPriceRes = await productRepository.getGoldPrice(
//         [action],
//         [pricingType],
//         [declareMaterial],
//         [usage],
//         [goldType],
//       );
//       PossGoldPriceResult? possGoldPriceResult = possGoldPriceRes.results.firstOrNull;
//
//       goldPrice = possGoldPriceResult?.price.toDouble();
//       double gram = storeProduct.inventory?.grossWeight?.gram ?? 0;
//       /* 計價商品工費 取inventory price */
//       double laborCost = storeProduct.inventory?.price ?? 0;
//
//       if (goldPrice != null) {
//         /* 計價商品貨牌價 = 金重(grossWeight) * 金價(goldPrice) + 工費(laborCost) */
//         inventoryAmount = (gram * goldPrice + laborCost).floorToDouble();
//       } else {
//         throw IllegalArgumentException(
//             "getStoreProductAmount failed _goldPrice[$goldPrice], _grossWeightGram[$gram]");
//       }
//       Logger.debug(message: '${storeProduct.inventory?.inventoryId} inventoryAmount $inventoryAmount');
//     }
//
//     /* 約定售價 從api取得 */
//     String? inventoryId = storeProduct.inventory?.inventoryId;
//     /* 如果是inventory商品則不帶modelSequenceNumber */
//     int? modelSequenceNumber = inventoryId != null ? null : storeProduct.model?.modelSequenceNumber.toInt();
//     Employee employee = await authenticationRepository.getEmployee();;
//
//     customerSessionRepository.currentCustomerSession(employee);
//
//     final String? customerId = customerSessionRepository.currentCustomerSession(employee)?.customerId;
//     PossProductDiscountCalculateRes? possInventorySingleDiscounts = await productRepository
//         .postProductDiscountCalculate(customerId: customerId, products: [
//       PossProductDiscountCalculateReqProduct(inventoryId: inventoryId, modelSequenceNumber: modelSequenceNumber)
//     ]);
//
//     PossSingleDiscountResult? singleDiscountResult = possInventorySingleDiscounts.singleDiscountResults.firstOrNull;
//     List<PossSingleDiscount> discounts =
//         singleDiscountResult?.discounts.where((e) => e.projectLineId != null).toList() ?? [];
//     PossSingleDiscount? selectedDiscount = discounts.firstOrNull;
//     if (discounts.isNotEmpty) {
//       Logger.debug(
//           message:
//               'got discounts from getSingleDiscounts response, length:${singleDiscountResult?.discounts.length}');
//       netAmount = discounts.map((e) => e.agreePrice).reduce(min).toDouble();
//       Logger.debug(message: 'found minimum price from discounts $netAmount');
//       selectedDiscount = discounts.firstWhere((e) => e.agreePrice == netAmount);
//       Logger.debug(message: 'found discount code of minimum price ${selectedDiscount.projectLineId}');
//     } else {
//       Logger.debug(message: 'got empty discounts from getSingleDiscounts response');
//       netAmount = inventoryAmount.floorToDouble();
//     }
//
//     return ProductAmount(inventoryAmount, netAmount, selectedDiscount, discounts, goldPrice);
//   } catch (e) {
//     Logger.error(message: "get product item net amount failed");
//     rethrow;
//   }
// }
}
