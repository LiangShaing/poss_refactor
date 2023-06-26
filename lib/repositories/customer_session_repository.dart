import 'dart:async';

import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';
import 'package:mobile_poss_gp01/repositories/repository.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/customer_session.dart';
import 'package:realm/realm.dart';
import 'package:collection/collection.dart';

class CustomerSessionRepository extends RealmRepository {
  StreamSubscription? _realmCustomerSessionResultsStream;
  RealmResults<CustomerSession>? customerSessionResults;

  // CustomerSessionRepository() {
  //   customerSessionResults = realmSyncDao.realm.query<CustomerSession>(
  //       r'departmentCode == $0 AND employeeId==$1 AND checkInIndicator == $2', ["689", "221470", true]);
  // }

  void bindCustomerSessionResultsStreamListen(EmployeePOJO employeePOJO, callbackFun) {
    _realmCustomerSessionResultsStream?.cancel();
    customerSessionResults = realmSyncDao.realm.query<CustomerSession>(
        r'departmentCode == $0 AND employeeId==$1 AND checkInIndicator == $2',
        [employeePOJO.defaultDepartmentCode, employeePOJO.employeeId, true]);
    _realmCustomerSessionResultsStream = customerSessionResults?.changes.listen(callbackFun);
  }

  Future<void> createCustomerSession(CustomerSession customerSession) async {
    realmSyncDao.realm.write(() {
      realmSyncDao.realm.add(customerSession);
    });
  }

  Future<void> closeCustomerSession(CustomerSession customerSession) async {
    realmSyncDao.realm.write(() {
      // realmSyncDao.realm.add(customerSession,update: true);
      /* 所有 checkInIndicator false */
      customerSessionResults?.where((e) => e.employeeId == customerSession.employeeId).forEach((e) {
        e.checkInIndicator = false;
      });
    });
  }

  CustomerSession? get currentCustomerSession {
    return customerSessionResults?.lastOrNull;
  }
}
