import 'package:realm/realm.dart';

part 'generated/inventory.g.dart';

@RealmModel()
@MapTo('inventory')
class _Inventory {
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;
  late String inventoryId;
  late List<_Bom> bom;
  late String currency;
  late String custodianDepartmentCode;
  late _Weight? grossWeight;
  late String? itemNumber;
  late double laborCost;
  late double modelSequenceNumber;
  late _Weight? physicalWeight;
  late double price;
  late double? quantity;
  late String? usage;
  late String? catalogItem;
  late String? generalLedgerInventoryClass;
  late String? inventoryStatus;
  late String? pendingIndicator;
  late List<_InventoryCertificates> inventoryCertificates;
}

@RealmModel(ObjectType.embeddedObject)
class _InventoryReference {
  @MapTo("zh_HK")
  late String? zhHK;
  @MapTo("zh_TW")
  late String? zhTW;
  @MapTo("en_US")
  late String? enUS;
  @MapTo("zh_CN")
  late String? zhCN;
  late String? referenceCode;
  late String? status;
}

@RealmModel(ObjectType.embeddedObject)
class _InventoryCertificates {
  late String? entryUser;
  late String? verifyCode;
  late String? certificateOrganization;
  late String? clarity;
  late String? color;
  late String? certificateNumber;
  late DateTime? entryDate;
  late String? inventoryId;
  late String? from;
  late double? certificateSeq;
}


@RealmModel(ObjectType.embeddedObject)
class _Bom {
  late String? materialClass;
  late double cost;
  late double caratWeight;
  late bool mainMaterialIndicator;
  late String? materialCategory;
  late _InventoryReference? diamondColor;
  late _InventoryReference? diamondShape;
  late _InventoryReference? diamondCutGrade;
  late double muBaseAmount;
  late double qty;
  late String? vvCode;
  late String inventoryId;
  late String? from;
  @MapTo("_id")
  late ObjectId id;
  late double seq;
  late _InventoryReference? diamondClarity;
  late _InventoryReference? diamondPolish;
  late _InventoryReference? diamondFluorescent;
  late _InventoryReference? diamondSymmetry;
  late List<_BomCertificate> bomCertificates;
}

@RealmModel(ObjectType.embeddedObject)
class _BomCertificate {
  late bool? cnPhysicalCertificateIndicator;
  late bool? physicalIndicator;
  late String? certificateOrganization;
  late String? certificateNumber;
  late String? inventoryId;
  late String? from;
  late String? createUser;
  late String? physicalCertificateIndicator;
  late String? reportPdfPath;
  late String? digitalCardPath;
}

@RealmModel(ObjectType.embeddedObject)
class _Weight {
  late double gram;
  late double raw;
}

@RealmModel(ObjectType.embeddedObject)
class _InventoryModel {
  late String costUnit;
  late String? cut;
  late String inventoryClass;
  late String? color;
  late String usage;
  late String? rawMaterialSize;
  late String? materialBrand;

  //TODO:待確認型態
  late String? settingWidth;
  late String? modelPictNbr;
  late String? setting;
  late String generalLedgerInventoryClass;
  late String? t18;
  late String finish;
  late String? statCde;
  late String goldType;
  late String? t17;
  late String? t19;
  late String productType;
  late String weightCode;
  late String? sieveSize;
  late String jwInd;
  late DateTime createDate;
  late String? materialClass;
  late String productClass;
  late double modelSequenceNumber;
  late String? shape;
  late String styleCatalogNumber;
  late DateTime lastModifiedDate;
  late String styleCatgInd;
  late String? materialCategory;
  late String? modelSize;
  late String modelDescription;
  late String? clarity;
  late String? t22;
  late String? t44;
  late String? vvCode;
  late String? t48;
  late String catalogItemNumber;
  late String modelNumber;
  late String? parntModelSeqNbr;
  late String withMuBaseIndicator;
}
