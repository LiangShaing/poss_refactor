import 'dart:async';

import 'package:mobile_poss_gp01/repositories/repository.dart';
import 'package:mobile_poss_gp01/resources/realm/model/customer_session.dart';
import 'package:realm/realm.dart';
import 'package:collection/collection.dart';

class CustomerSessionRepository extends RealmRepository {
  StreamSubscription? _realmCustomerSessionResultsStream;
  RealmResults<CustomerSession>? customerSessionResults;

  CustomerSessionRepository() {
    customerSessionResults = realmSyncDao.realm.query<CustomerSession>(
        r'departmentCode == $0 AND employeeId==$1 AND checkInIndicator == $2', ["689", "221470", true]);
  }

  void bindCustomerSessionResultsStreamListen(callbackFun) {
    _realmCustomerSessionResultsStream?.cancel();
    _realmCustomerSessionResultsStream = customerSessionResults?.changes.listen(callbackFun);
  }

  Future<void> createCustomerSession(CustomerSession customerSession) async {
    realmSyncDao.realm.write(() {
      realmSyncDao.realm.add(customerSession);
    });
  }

  CustomerSession? get currentCustomerSession {
    return customerSessionResults?.lastOrNull;
  }
}
