import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_info.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:mobile_poss_gp01/enum/sale_type.dart';
import 'package:mobile_poss_gp01/events/product_info_event.dart';
import 'package:mobile_poss_gp01/services/product/product_service.dart';
import 'package:mobile_poss_gp01/states/product_info_state.dart';

class ProductInfoBloc extends AbstractBloc<ProductInfoEvent, ProductInfoState> {
  ProductInfoBloc() : super(ProductInfoLoadInitial()) {
    on<StoreProductInfoProgressed>(_processProductDataFromStore);
  }

  void _processProductDataFromStore(StoreProductInfoProgressed event, Emitter<ProductInfoState> emit) async {
    emit(ProductInfoLoadInProgress());
    await Future.delayed(const Duration(seconds: 1));
    ProductService productService = ProductService();
    CatalogItem? catalogItem = event.storeProduct.catalogItem;
    Model? model = event.storeProduct.model;
    Inventory? inventory = event.storeProduct.inventory;

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

    emit(ProductInfoLoadSuccess(info));
  }
}
