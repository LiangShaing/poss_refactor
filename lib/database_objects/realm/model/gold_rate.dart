import 'package:realm/realm.dart';

part 'generated/gold_rate.g.dart';

@RealmModel()
@MapTo('goldRate')
class _GoldRate {
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;
  late String ccy;
  late DateTime effectiveDate;
  late String from;
  late String goldRateTypeCode;
  late bool includeLaborCostIndicator;
  late bool isBarIndicator;
  late bool isGoldIndicator;
  late DateTime lastModifyDate;
  late String lastModifyUser;
  late double rate;
  late String rateId;
  @MapTo("zh_CN")
  late String zhCN;
}
