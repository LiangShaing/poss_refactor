import 'package:realm/realm.dart';

part 'generated/catalog_item.g.dart';

@RealmModel()
@MapTo('catalogItem')
class _CatalogItem {
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;
  late String catalogItem;
  late _ProductSampleInfoObject? brand;
  late _Reference? goldType;
  late String? pricingType;
  late _Reference? usage;
  late _Collection? subCollection;
  late _Collection? collection;
  late _Reference? declaredMaterial;
  late List<String> departmentCodes;
  late _Reference? materialCategory;
  late List<_ProductTagType> earringsType;
}


@RealmModel(ObjectType.embeddedObject)
class _Reference {
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
class _Material {
  @MapTo("zh_HK")
  late String zhHK;
  @MapTo("zh_TW")
  late String zhTW;
  @MapTo("en_US")
  late String enUS;
  @MapTo("zh_CN")
  late String zhCN;
  late String materialCode;
  late String? materialDescription;
  late String? productType;
  late String status;
}


@RealmModel(ObjectType.embeddedObject)
class _ProductTagType {
  // @MapTo("PROD_TAG_ID")
  // late int? prodTagId;
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
class _ProductDescription {
  @MapTo("FDM_productDescription_id")
  late ObjectId fdmProductDescriptionId;
  @MapTo("zh_HK")
  late String zhHK;
  @MapTo("en_US")
  late String enUS;
  @MapTo("zh_CN")
  late String zhCN;
  late int productId;

}

@RealmModel(ObjectType.embeddedObject)
class _StyleCategoryDetail {
  @MapTo("MIN_MODEL_SIZE")
  late String? minModelSize;
  @MapTo("ENGRAVE_TYPE")
  late String? engraveType;
  @MapTo("zh_HK")
  late String? zhHK;
  late bool allowIndicator;
  late String usage;
  late String styleCategoryNumber;
  @MapTo("zh_CN")
  late String? zhCN;
  @MapTo("MAX_MODEL_SIZE")
  late String? maxModelSize;
  @MapTo("FDM_styleCategoryDetails_id")
  late ObjectId? fdmCategoryDetailsId;
  late String? remarkType;
}


@RealmModel(ObjectType.embeddedObject)
class _QcAccept {
  late int productId;
  late DateTime entryDate;
  late double upperBound;
  late double lowerBound;
  late String? remark;
  late String? entryUserId;
  late int seq;
  @MapTo("FDM_qcAccept_id")
  late ObjectId fdmQcAcceptId;
  late String weightUnit;
}


@RealmModel(ObjectType.embeddedObject)
class _MarketingKeyword {
  late int productId;
  @MapTo("FDM_productMarketingKeyword_id")
  late ObjectId fdmProductMarketingKeywordId;
  late int id;
  late String status;
  @MapTo("MDM_marketingKeyword_id")
  late ObjectId mdmMarketingKeywordId;
  @MapTo("zh_HK")
  late String zhHK;
  @MapTo("en_US")
  late String enUS;
  @MapTo("zh_CN")
  late String zhCN;
}


@RealmModel(ObjectType.embeddedObject)
class _Collection{
  late String code;
  @MapTo("en_US")
  late String enUS;
  late String status;
  @MapTo("zh_CN")
  late String zhCN;
  @MapTo("zh_HK")
  late String zhHK;


}

@RealmModel(ObjectType.embeddedObject)
class _ProductSampleInfoObject{
  late String code;
  @MapTo("en_US")
  late String enUS;
  late String status;
  @MapTo("zh_CN")
  late String zhCN;
  @MapTo("zh_HK")
  late String zhHK;
}


@RealmModel(ObjectType.embeddedObject)
class _PhysicalWeight{
  late String lastModifyUser;
  late String sizeReferenceCode;
  @MapTo("FDM_standardSpecificationPhysicalWeight_id")
  late ObjectId fdmStandardSpecificationPhysicalWeightId;
  late int productId;
  late double upperBound;
  late double lowerBound;
  late DateTime lastModifyDate;
  late String weightUnit;
}
