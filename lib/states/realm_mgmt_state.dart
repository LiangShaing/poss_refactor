import 'package:equatable/equatable.dart';

abstract class RealmMgmtState<T> extends Equatable {
  final bool isLogin;
  final bool isUpdateSubscriptions;
  final bool isRealmConnect;

  const RealmMgmtState({
    required this.isLogin,
    required this.isUpdateSubscriptions,
    required this.isRealmConnect,
  }) : super();

  @override
  List<Object?> get props => [isLogin, isUpdateSubscriptions, isRealmConnect];
}

class RealmMgmtAuthenticatedInitial extends RealmMgmtState {
  const RealmMgmtAuthenticatedInitial(
      {required super.isLogin, required super.isUpdateSubscriptions, required super.isRealmConnect});

  @override
  List<Object> get props => [];
}

class RealmMgmtLoadInProgress extends RealmMgmtState {
  const RealmMgmtLoadInProgress(
      {required super.isLogin, required super.isUpdateSubscriptions, required super.isRealmConnect});

  @override
  List<Object> get props => [];
}

class RealmMgmtAuthenticatedSuccess extends RealmMgmtState {
  const RealmMgmtAuthenticatedSuccess(
      {required super.isLogin, required super.isUpdateSubscriptions, required super.isRealmConnect});

  @override
  List<Object> get props => [];
}

class RealmMgmtLoadFailure extends RealmMgmtState {
  const RealmMgmtLoadFailure(
      {required super.isLogin, required super.isUpdateSubscriptions, required super.isRealmConnect});

  @override
  List<Object> get props => [];
}

class RealmMgmtSubscriptionsUpdatedSuccess extends RealmMgmtState {
  const RealmMgmtSubscriptionsUpdatedSuccess(
      {required super.isLogin, required super.isUpdateSubscriptions, required super.isRealmConnect});

  @override
  List<Object> get props => [];
}
