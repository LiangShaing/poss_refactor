import 'package:equatable/equatable.dart';

abstract class RealmAuthorizedState<T> extends Equatable {
  final bool isLogin;
  final bool isUpdateSubscriptions;
  final bool isRealmConnect;

  const RealmAuthorizedState({
    required this.isLogin,
    required this.isUpdateSubscriptions,
    required this.isRealmConnect,
  }) : super();

  @override
  List<Object?> get props => [isLogin, isUpdateSubscriptions, isRealmConnect];
}

class RealmStatePermissionUnauthenticated extends RealmAuthorizedState {
  const RealmStatePermissionUnauthenticated(
      {required super.isLogin, required super.isUpdateSubscriptions, required super.isRealmConnect});

  @override
  List<Object> get props => [];
}

class RealmAuthorizedStateLoading extends RealmAuthorizedState {
  const RealmAuthorizedStateLoading(
      {required super.isLogin, required super.isUpdateSubscriptions, required super.isRealmConnect});

  @override
  List<Object> get props => [];
}

class RealmStatePermissionAuthenticated extends RealmAuthorizedState {
  const RealmStatePermissionAuthenticated(
      {required super.isLogin, required super.isUpdateSubscriptions, required super.isRealmConnect});

  @override
  List<Object> get props => [];
}

class RealmAuthorizedStateError extends RealmAuthorizedState {
  const RealmAuthorizedStateError(
      {required super.isLogin, required super.isUpdateSubscriptions, required super.isRealmConnect});

  @override
  List<Object> get props => [];
}

class RealmStateSubscriptionsUpdated extends RealmAuthorizedState {
  const RealmStateSubscriptionsUpdated(
      {required super.isLogin, required super.isUpdateSubscriptions, required super.isRealmConnect});

  @override
  List<Object> get props => [];
}
