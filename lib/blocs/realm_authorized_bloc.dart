import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/events/realm_authorized_event.dart';
import 'package:mobile_poss_gp01/repositories/realm_authorized_repository.dart';
import 'package:mobile_poss_gp01/states/realm_authorized_state.dart';
import 'package:realm/realm.dart';
import 'dart:developer';

class RealmAuthorizedBloc extends AbstractBloc<RealmAuthorizedEvent, RealmAuthorizedState> {
  final RealmAuthorizedRepository realmAuthorizedRepository;

  RealmAuthorizedBloc({required this.realmAuthorizedRepository})
      : super(const RealmStatePermissionUnauthenticated(
          isLogin: false,
          isUpdateSubscriptions: false,
          isRealmConnect: false,
        )) {
    on<RealmLoginStarted>(_realmLoginStarted);
    on<RealmLogoutStarted>(_realmLogoutStarted);
    on<RealmConnectStateChange>(_realmConnectStateChange);
    on<RealmUpdateSubscriptions>(_realmUpdateSubscriptions);
  }

  Future<void> _realmLoginStarted(RealmLoginStarted event, Emitter<RealmAuthorizedState> emit) async {
    try {
      final state = this.state;
      if (state.isLogin == true) {
        log("_realmLoginStarted is login");
        return;
      }

      emit(const RealmAuthorizedStateLoading(
        isLogin: false,
        isUpdateSubscriptions: false,
        isRealmConnect: false,
      ));

      await realmAuthorizedRepository.logIn();
      realmAuthorizedRepository.bindConnectionStreamListen(_connectionStream);
      realmAuthorizedRepository.bindUploadProgressStreamListen(_uploadProgressStream);
      realmAuthorizedRepository.bindDownloadProgressStreamListen(_downloadProgressStream);
      emit(const RealmStatePermissionAuthenticated(isLogin: true, isUpdateSubscriptions: false, isRealmConnect: false));
    } catch (e) {
      log('RealmLoginBloc _realmLoginStarted : ${e.toString()}');
      emit(const RealmAuthorizedStateError(isLogin: false, isUpdateSubscriptions: false, isRealmConnect: false));
    }
  }

  Future<void> _realmLogoutStarted(RealmLogoutStarted event, Emitter<RealmAuthorizedState> emit) async {
    try {
      final state = this.state;
      if (state.isLogin == false) {
        log("_realmLogoutStarted not login");
        return;
      }
      await realmAuthorizedRepository.closeRealm();
      await realmAuthorizedRepository.logOut();
      emit(const RealmStatePermissionUnauthenticated(
        isLogin: false,
        isUpdateSubscriptions: false,
        isRealmConnect: false,
      ));
    } catch (e) {
      log('RealmLoginBloc _realmLogoutStarted : ${e.toString()}');
      emit(const RealmAuthorizedStateError(isLogin: false, isUpdateSubscriptions: false, isRealmConnect: false));
    }
  }

  void _realmConnectStateChange(RealmConnectStateChange event, Emitter<RealmAuthorizedState> emit) {
    try {
      final state = this.state;
      emit(RealmStatePermissionAuthenticated(
        isLogin: true,
        isUpdateSubscriptions: state.isUpdateSubscriptions,
        isRealmConnect: event.isConnected,
      ));
    } catch (e) {
      log('RealmLoginBloc _realmLogoutStarted : ${e.toString()}');
      emit(const RealmAuthorizedStateError(isLogin: true, isUpdateSubscriptions: false, isRealmConnect: false));
    }
  }

  Future<void> _realmUpdateSubscriptions(RealmUpdateSubscriptions event, Emitter<RealmAuthorizedState> emit) async {
    emit(const RealmAuthorizedStateLoading(
      isLogin: true,
      isUpdateSubscriptions: false,
      isRealmConnect: true,
    ));
    try {
      final state = this.state;
      if (state.isLogin == false) {
        log("_realmUpdateSubscriptions not login");
        return;
      } else if (state.isUpdateSubscriptions == true) {
        log("_realmUpdateSubscriptions is sync");
        return;
      }
      await realmAuthorizedRepository.updateSubscriptions();

      emit(const RealmStateSubscriptionsUpdated(
        isLogin: true,
        isUpdateSubscriptions: true,
        isRealmConnect: true,
      ));
    } catch (e) {
      log('RealmLoginBloc _realmLogoutStarted : ${e.toString()}');
      emit(const RealmAuthorizedStateError(isLogin: true, isUpdateSubscriptions: false, isRealmConnect: false));
    }
  }

  void _connectionStream(ConnectionStateChange event) {
    log("===============ConnectionStateChange ${event.current.name}===============");

    if (event.current == ConnectionState.connected) {
      add(RealmConnectStateChange(isConnected: true));
    }

    if (event.current == ConnectionState.disconnected) {
      add(RealmConnectStateChange(isConnected: false));
    }
  }

  void _uploadProgressStream(SyncProgress event) {
    log("===============SyncProgress realmProgressUploadStream transferableBytes[${event.transferableBytes}], transferableBytes[${event.transferredBytes}]===============");
  }

  void _downloadProgressStream(SyncProgress event) {
    log("===============SyncProgress realmProgressDownloadStream transferableBytes[${event.transferableBytes}], transferableBytes[${event.transferredBytes}]===============");
  }
}
