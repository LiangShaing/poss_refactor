import 'package:realm/realm.dart';

part 'generated/model.g.dart';

///Model
@RealmModel()
@MapTo('model')
class _Model {
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;
  late double modelSequenceNumber;
  late String catalogItem;
  late bool fixedPriceIndicator;
  late _ModelReference? usage;
  late String? pricingType;
  late List<String> departmentCodes;
  late _ModelReference? ringSize;
  late _ModelReference? length;
  late _ProductTitle? productTitle;
}

@RealmModel(ObjectType.embeddedObject)
class _ModelReference {
  @MapTo("zh_HK")
  late String? zhHK;
  @MapTo("zh_TW")
  late String? zhTW;
  @MapTo("en_US")
  late String? enUS;
  @MapTo("zh_CN")
  late String? zhCN;
  late String referenceCode;
  late String? status;
}

@RealmModel(ObjectType.embeddedObject)
class _ProductTitle {
  @MapTo("zh_HK")
  late String? zhHK;
  @MapTo("zh_TW")
  late String? zhTW;
  @MapTo("en_US")
  late String? enUS;
  @MapTo("zh_CN")
  late String? zhCN;
}

@RealmModel(ObjectType.embeddedObject)
class _Group {
  late String code;
  @MapTo("zh_HK")
  late String zhHK;
  @MapTo("en_US")
  late String enUS;
  @MapTo("zh_CN")
  late String zhCN;
  late int id;
}

@RealmModel(ObjectType.embeddedObject)
class _WeightRange {
  late double lowerBound;
  late double upperBound;
  late String weightUnit;
}
