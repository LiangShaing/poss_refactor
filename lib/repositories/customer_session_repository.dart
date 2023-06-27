import 'dart:async';

import 'package:mobile_poss_gp01/data_provider/customer_session_data_provider.dart';
import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/customer_session.dart';
import 'package:realm/realm.dart';
import 'package:collection/collection.dart';

class CustomerSessionRepository {
  CustomerSessionDataProvider dataProvider = CustomerSessionDataProvider();
  StreamSubscription? _realmCustomerSessionResultsStream;
  RealmResults<CustomerSession>? customerSessionResults;

  void bindCustomerSessionResultsStreamListen(EmployeePOJO employeePOJO, callbackFun) {
    _realmCustomerSessionResultsStream?.cancel();
    customerSessionResults = dataProvider.findCurrentCustomerSessionByEmployee(employeePOJO);
    _realmCustomerSessionResultsStream = customerSessionResults?.changes.listen(callbackFun);
  }

  Future<void> createCustomerSession(CustomerSession customerSession) async {
    dataProvider.createCustomerSession(customerSession);
  }

  Future<void> closeCustomerSession(CustomerSession customerSession) async {
    dataProvider.closeCustomerSession(customerSession);
    // realmSyncDao.realm.write(() {
    //   // realmSyncDao.realm.add(customerSession,update: true);
    //   /* 所有 checkInIndicator false */
    //   customerSessionResults?.where((e) => e.employeeId == customerSession.employeeId).forEach((e) {
    //     e.checkInIndicator = false;
    //   });
    // });
  }

  CustomerSession? get currentCustomerSession {
    return customerSessionResults?.lastOrNull;
  }
}
