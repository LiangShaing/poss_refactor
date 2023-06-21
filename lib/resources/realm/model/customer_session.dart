import 'package:realm/realm.dart';

part 'generated/customer_session.g.dart';

@RealmModel()
@MapTo('customerSession')
class _CustomerSession {
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;
  late _ShoppingBag? shoppingBag;
  late bool checkInIndicator;
  late DateTime createdDate;
  late DateTime? lastModifiedDate;
  late String? currentProgress;
  late String? code;
  late String departmentCode;
  late String employeeId;
  late String employeeName;
  late DateTime? endedDate;
  late String? customerName;
  late List<_BrowsingHistories> browsingHistories;
  late _UIPersistShoppingBag? uiPersistShoppingBag;
}

@RealmModel()
@MapTo('shoppingBag')
class _ShoppingBag {
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;
  late DateTime createdDate;
  late String? ctId;
  late String? settlementTransactionId;
  late String? currency;
  late DateTime? lastModifiedDate;
  late String? signatureBase64Data;
  late String? customerId;
  late String? departmentCode;
  late List<_ShoppingBagItem> items;
}

@RealmModel(ObjectType.embeddedObject)
class _ShoppingBagItem {
  late ObjectId id;
  late String? selectedDiscountProjectLineId;
  late String? discountName;
  late int? ctLineNumber;
  late double? modelSequenceNumber;
  late String? inventoryId;
  late double? inventoryAmount;
  late DateTime createdDate;
  late int? quantity;
  late String? saleType;
  late DateTime? lastModifiedDate;
  late double? netAmount;
  late double? laborCost;

}

@RealmModel(ObjectType.embeddedObject)
class _BrowsingHistories {
  late DateTime createdDate;
  late double? modelSequenceNumber;
  late String? inventoryId;
  late String? saleType;
}


@RealmModel(ObjectType.embeddedObject)
class _UIPersistShoppingBag {
  late List<_CacheProductItem> cacheProductItems;
}

@RealmModel(ObjectType.embeddedObject)
class _CacheProductItem {
  late ObjectId id;
  late double? modelSequenceNumber;
  late String? inventoryId;
  late String? itemNumber;
  late DateTime createdDate;
  late List<String> imagesPath;
  late double? netAmount;
  late double? inventoryAmount;

  // late double? laborCost;
  late List<_ProductDiscount> discounts;
  late _ProductDiscount? selectedProductDiscount;
  late int? lineNumber;
  late String? saleType;

  late String? productName;
  late String? catalogItemCode;
  late _CatalogItemTitle? brand;
  late _CatalogItemTitle? collection;
  late _CatalogItemTitle? subCollection;
  late bool? fixedPriceIndicator;
  late double? goldPrice;
  late _BookingUnit? bookingUnitInfo;
}

@RealmModel(ObjectType.embeddedObject)
class _ProductDiscount {
  late String projectLineId;
  late String discountName;
  late double agreePrice;
}

@RealmModel(ObjectType.embeddedObject)
class _CatalogItemTitle {
  late String? code;
  late String? name;
}

@RealmModel(ObjectType.embeddedObject)
class _BookingUnit {
  late _BookingUnitsCbu? cbu;
  late int? earmarkQuantity;
  // late String? modelNumber;
  late double? modelSequenceNumber;
  late String? departmentCode;
  // late String? departmentName;
  late String? shape;
  late String? diamondBrand;
  late String? materialCategory;
  late int? qty;
  late int? price;
  late String? goldType;
  late double? caratWeight;
  // late String? weightCode;
  late String? color;
  // late double? grossWeightTael;
  late double? grossWeightGram;
  // late double? bookWeightTael;
  // late double? bookWeightGram;
  // late double? physicalWeightTael;
  late double? physicalWeightGram;
  late double? laborCost;
  late String? size;
  late String? inventoryState;
  late String? clarity;
  late String? cutGrade;
  late String? polish;
  late String? fluorescent;
  late String? symmetry;
  late String? bomCertificateOrganization;
  late String? usageReferenceCode;
  late String? sizeAndLength;
}

@RealmModel(ObjectType.embeddedObject)
class _BookingUnitsCbu {
  late String? inventoryId;
  late double? modelSequenceNumber;
}
