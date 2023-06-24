import 'dart:async';

import 'package:mobile_poss_gp01/database_objects/realm/model/gold_rate.dart';
import 'package:mobile_poss_gp01/database_objects/realm/pojo/gold_rate_pojo.dart';
import 'package:mobile_poss_gp01/repositories/repository.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/customer_session.dart';
import 'package:realm/realm.dart';
import 'package:collection/collection.dart';

class GoldRateRepository extends RealmRepository {
  StreamSubscription? _realmResultsStream;
  RealmResults<GoldRate>? goldRateResults;

  GoldRateRepository() {
    goldRateResults = realmSyncDao.realm.all<GoldRate>();
  }

  void bindGoldRateResultsStreamListen(callbackFun) {
    _realmResultsStream?.cancel();
    _realmResultsStream = goldRateResults?.changes.listen(callbackFun);
  }

  List<GoldRatePOJO> get goldRateData {
    return goldRateResults
            ?.map((e) => GoldRatePOJO(
                e.id,
                e.ccy,
                e.effectiveDate,
                e.from,
                e.goldRateTypeCode,
                e.includeLaborCostIndicator,
                e.isBarIndicator,
                e.isGoldIndicator,
                e.lastModifyDate,
                e.lastModifyUser,
                e.rate,
                e.rateId,
                e.zhCN))
            .toList() ??
        [];
  }
}
