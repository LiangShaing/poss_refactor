class ProductInfo {
  String? catalogItemCode;
  String? productName;
  String? finalBrandCollection;
  String? finalCollection;
  bool fixedPriceIndicator;
  double? modelSequenceNumber;
  String? inventoryId;
  String? itemNumber;
  String? saleType;
  double? goldPrice;
  String? generalLedgerInventoryClass;
  String? earringTypeDescription;
  String? goldTypeDescription;
  String? materialCategoryDescription;
  String? usageDescription;
  String? usageCode;
  double? standardSpecificationPhysicalWeightLowerBound;
  double? price;

  ProductBookingUnit? bookingUnit;
  String? pricingType;
  String? declareMaterial;
  String? usage;
  String? goldType;

  ProductInfo(
      {this.catalogItemCode,
      this.productName,
      this.finalBrandCollection,
      this.finalCollection,
      required this.fixedPriceIndicator,
      this.modelSequenceNumber,
      this.inventoryId,
      this.itemNumber,
      this.saleType,
      this.goldPrice,
      this.generalLedgerInventoryClass,
      this.earringTypeDescription,
      this.goldTypeDescription,
      this.materialCategoryDescription,
      this.usageDescription,
      this.usageCode,
      this.standardSpecificationPhysicalWeightLowerBound,
      this.bookingUnit,
      this.price,
      this.pricingType,
      this.declareMaterial,
      this.usage,
      this.goldType});

  ProductInfo.clone(ProductInfo ori)
      : this(
            catalogItemCode: ori.catalogItemCode,
            productName: ori.productName,
            finalBrandCollection: ori.finalBrandCollection,
            finalCollection: ori.finalCollection,
            fixedPriceIndicator: ori.fixedPriceIndicator,
            modelSequenceNumber: ori.modelSequenceNumber,
            inventoryId: ori.inventoryId,
            itemNumber: ori.itemNumber,
            saleType: ori.saleType,
            goldPrice: ori.goldPrice,
            generalLedgerInventoryClass: ori.generalLedgerInventoryClass,
            earringTypeDescription: ori.earringTypeDescription,
            goldTypeDescription: ori.goldTypeDescription,
            materialCategoryDescription: ori.materialCategoryDescription,
            usageDescription: ori.usageDescription,
            usageCode: ori.usageCode,
            standardSpecificationPhysicalWeightLowerBound: ori.standardSpecificationPhysicalWeightLowerBound,
            bookingUnit: ori.bookingUnit,
            price: ori.price,
            pricingType: ori.pricingType,
            declareMaterial: ori.declareMaterial,
            usage: ori.usage,
            goldType: ori.goldType);
}

class ProductBookingUnit {
  ProductCbu cbu;
  int? earmarkQuantity;
  String? modelNumber;
  String? itemNumber;
  String? itemNumberWithCheckDigit;
  double? modelSequenceNumber;
  String? shape;
  String? diamondBrand;
  String? materialCategory;
  int? qty;
  double? price;
  String? goldType;
  double? caratWeight;
  String? weightCode;
  String? color;
  String? clarity;
  String? cutGrade;
  String? polish;
  String? symmetry;
  String? fluorescent;
  String? bomCertificateOrganization;
  List<ProductBomCertificate>? bomCertificates;
  String? pearlDiameterRange;
  double? grossWeightGram;
  double? bookWeightGram;
  double? physicalWeightGram;
  int? laborCost;
  String? inventoryState;
  String? productLifeCycleCode;
  String? size;
  String? inventoryCertificates;
  String? currencyCode;
  String? pendingIndicator;
  String? inventoryStatus;
  double? standardSpecificationPhysicalWeightLowerBound;
  double? physicalWeightLowerBound;
  List<ProductBom> bom;

  ProductBookingUnit(
      {required this.cbu,
      this.earmarkQuantity,
      this.modelNumber,
      this.itemNumber,
      this.itemNumberWithCheckDigit,
      this.modelSequenceNumber,
      this.shape,
      this.diamondBrand,
      this.materialCategory,
      this.qty,
      this.price,
      this.goldType,
      this.caratWeight,
      this.weightCode,
      this.color,
      this.clarity,
      this.cutGrade,
      this.polish,
      this.symmetry,
      this.fluorescent,
      this.bomCertificateOrganization,
      this.bomCertificates,
      this.pearlDiameterRange,
      this.grossWeightGram,
      this.bookWeightGram,
      this.physicalWeightGram,
      this.laborCost,
      this.inventoryState,
      this.productLifeCycleCode,
      this.size,
      this.inventoryCertificates,
      this.currencyCode,
      this.pendingIndicator,
      this.inventoryStatus,
      this.standardSpecificationPhysicalWeightLowerBound,
      this.physicalWeightLowerBound,
      this.bom = const []});
}

class ProductBom {
  double? caratWeight;
  String? color;
  String? clarity;
  String? cutGrade;
  List<ProductBomCertificate> bomCertificates;

  ProductBom({this.caratWeight, this.color, this.clarity, this.cutGrade, this.bomCertificates = const []});
}

class ProductCbu {
  int? modelSequenceNumber;
  String? inventoryId;

  ProductCbu({this.modelSequenceNumber, this.inventoryId});

  ProductCbu.clone(ProductCbu ori) : this(modelSequenceNumber: ori.modelSequenceNumber, inventoryId: ori.inventoryId);
}

class ProductBomCertificate {
  String physicalCertificateIndicator;
  String certificateOrganization;
  String certificateNumber;
  String? reportPdfPath;
  String? digitalCardPath;

  ProductBomCertificate(
      {required this.physicalCertificateIndicator,
      required this.certificateOrganization,
      required this.certificateNumber,
      this.reportPdfPath,
      this.digitalCardPath});
}
