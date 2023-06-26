import 'package:realm/realm.dart';

part 'generated/earmark.g.dart';

@RealmModel()
@MapTo('earmark')
class _Earmark {
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;
  // late String? circleKey;
  late String? circleUnit;
  late String? departmentCode;
  late String? inventoryId;
  // late DateTime? lastIncludeDate;
  @MapTo("last_modified_date")
  late DateTime? lastModifiedDate;
  late double? modelSequenceNumber;
  // late DateTime? prebuildDate;
  // late String? pricingType;
  late String? purposeCode;
  // late String? purposeDescription;
  late double? quantity;
  late String? tag;
  late String? catalogItem;
  // late String? tagDescription;
}
