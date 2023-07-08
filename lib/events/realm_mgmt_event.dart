import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';

abstract class RealmMgmtEvent {}

class RealmMgmtLoginRequested extends RealmMgmtEvent {
  final Employee? employeePOJO;

  RealmMgmtLoginRequested({this.employeePOJO});
}

class RealmMgmtUpdateSubscriptionsStarted extends RealmMgmtEvent {
  final Employee employeePOJO;

  RealmMgmtUpdateSubscriptionsStarted({required this.employeePOJO});
}

class RealmMgmtLogoutRequested extends RealmMgmtEvent {}

class RealmMgmtConnectStateChanged extends RealmMgmtEvent {
  final bool isConnected;

  RealmMgmtConnectStateChanged({required this.isConnected});
}

// class RealmUpdateSubscriptions extends RealmMgmtEvent {}
