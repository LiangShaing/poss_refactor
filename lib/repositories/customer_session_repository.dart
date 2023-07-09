import 'dart:async';

import 'package:mobile_poss_gp01/data_provider/customer_session_data_provider.dart';
import 'package:mobile_poss_gp01/data_provider/shopping_bag_data_provider.dart';
import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/customer_session.dart';
import 'package:realm/realm.dart';
import 'package:collection/collection.dart';

class CustomerSessionRepository {
  CustomerSessionDataProvider dataProvider = CustomerSessionDataProvider();
  ShoppingBagDataProvider  shoppingBagDataProvider = ShoppingBagDataProvider();
  StreamSubscription? _realmCustomerSessionResultsStream;
  RealmResults<CustomerSession>? customerSessionResults;

  void bindCustomerSessionResultsStreamListen(Employee employee, callbackFun) {
    _realmCustomerSessionResultsStream?.cancel();
    customerSessionResults = dataProvider.findCurrentCustomerSessionByEmployee(employee);
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

  CustomerSession? currentCustomerSession(Employee employee) {
    return dataProvider.findCurrentCustomerSessionByEmployee(employee).lastOrNull;
  }

  Future<void> createBrowsingHistories(CustomerSession customerSession, BrowsingHistories browsingHistories) async {
    dataProvider.createBrowsingHistories(customerSession, browsingHistories);
  }

  Future<void> addItemToShoppingBag(CustomerSession customerSession, ShoppingBagItem shoppingBagItem) async {
    shoppingBagDataProvider.addItemToShoppingBag(customerSession, shoppingBagItem);
  }
}
