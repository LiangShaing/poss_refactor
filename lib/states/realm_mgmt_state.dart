import 'package:equatable/equatable.dart';
import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';

abstract class RealmMgmtState<T> extends Equatable {
  final bool isLogin;
  final bool isUpdateSubscriptions;
  final bool isRealmConnect;
  final Employee? employee;

  const RealmMgmtState(
      {required this.isLogin, required this.isUpdateSubscriptions, required this.isRealmConnect, this.employee})
      : super();

  @override
  List<Object?> get props => [isLogin, isUpdateSubscriptions, isRealmConnect,employee];
}

class RealmMgmtAuthenticatedInitial extends RealmMgmtState {
  const RealmMgmtAuthenticatedInitial(
      {required super.isLogin,
      required super.isUpdateSubscriptions,
      required super.isRealmConnect,
      super.employee});

  @override
  List<Object> get props => [];
}

class RealmMgmtLoadInProgress extends RealmMgmtState {
  const RealmMgmtLoadInProgress(
      {required super.isLogin,
      required super.isUpdateSubscriptions,
      required super.isRealmConnect,
      super.employee});

  @override
  List<Object> get props => [];
}

class RealmMgmtAuthenticatedSuccess extends RealmMgmtState {
  const RealmMgmtAuthenticatedSuccess(
      {required super.isLogin,
      required super.isUpdateSubscriptions,
      required super.isRealmConnect,
      super.employee});

  @override
  List<Object> get props => [];
}

class RealmMgmtLoadFailure extends RealmMgmtState {
  const RealmMgmtLoadFailure(
      {required super.isLogin,
      required super.isUpdateSubscriptions,
      required super.isRealmConnect,
      super.employee});

  @override
  List<Object> get props => [];
}

class RealmMgmtSubscriptionsLoadInProgress extends RealmMgmtState {
  const RealmMgmtSubscriptionsLoadInProgress(
  {required super.isLogin,
  required super.isUpdateSubscriptions,
  required super.isRealmConnect,
  super.employee});

@override
List<Object> get props => [];
}

class RealmMgmtSubscriptionsUpdatedSuccess extends RealmMgmtState {
  const RealmMgmtSubscriptionsUpdatedSuccess(
      {required super.isLogin,
      required super.isUpdateSubscriptions,
      required super.isRealmConnect,
      super.employee});

  @override
  List<Object> get props => [];
}

class RealmMgmtLogoutSuccess extends RealmMgmtState {
  const RealmMgmtLogoutSuccess({required super.isLogin, required super.isUpdateSubscriptions, required super.isRealmConnect});
}
