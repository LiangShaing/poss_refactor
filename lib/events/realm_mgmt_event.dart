import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';

abstract class RealmMgmtEvent {}

class RealmMgmtLoginRequested extends RealmMgmtEvent {}

class RealmMgmtUpdateSubscriptionsStarted extends RealmMgmtEvent {
  final EmployeePOJO? employeePOJO;

  RealmMgmtUpdateSubscriptionsStarted({this.employeePOJO});
}

class RealmMgmtLogoutRequested extends RealmMgmtEvent {}

class RealmMgmtConnectStateChanged extends RealmMgmtEvent {
  final bool isConnected;

  RealmMgmtConnectStateChanged({required this.isConnected});
}

// class RealmUpdateSubscriptions extends RealmMgmtEvent {}
