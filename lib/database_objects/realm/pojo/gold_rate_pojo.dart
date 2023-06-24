import 'package:realm/realm.dart';

class GoldRatePOJO {
  const GoldRatePOJO(
      this.id,
      this.ccy,
      this.effectiveDate,
      this.from,
      this.goldRateTypeCode,
      this.includeLaborCostIndicator,
      this.isBarIndicator,
      this.isGoldIndicator,
      this.lastModifyDate,
      this.lastModifyUser,
      this.rate,
      this.rateId,
      this.zhCN);

  final ObjectId id;
  final String ccy;
  final DateTime effectiveDate;
  final String from;
  final String goldRateTypeCode;
  final bool includeLaborCostIndicator;
  final bool isBarIndicator;
  final bool isGoldIndicator;
  final DateTime lastModifyDate;
  final String lastModifyUser;
  final double rate;
  final String rateId;
  final String zhCN;
}
