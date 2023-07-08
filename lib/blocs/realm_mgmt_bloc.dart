import 'package:chowsangsang_enterprise_portal/service_factory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/database_objects/realm/pojo/subscription_req.dart';
import 'package:mobile_poss_gp01/events/realm_mgmt_event.dart';
import 'package:mobile_poss_gp01/repositories/realm_authorized_repository.dart';
import 'package:mobile_poss_gp01/states/realm_mgmt_state.dart';
import 'package:realm/realm.dart';
import 'dart:developer';

class RealmMgmtBloc extends AbstractBloc<RealmMgmtEvent, RealmMgmtState> {
  final RealmAuthorizedRepository realmAuthorizedRepository;

  RealmMgmtBloc({required this.realmAuthorizedRepository})
      : super(const RealmMgmtAuthenticatedInitial(
          isLogin: false,
          isUpdateSubscriptions: false,
          isRealmConnect: false,
        )) {
    on<RealmMgmtLoginRequested>(_realmLoginStarted);
    on<RealmMgmtLogoutRequested>(_realmLogoutStarted);
    on<RealmMgmtConnectStateChanged>(_realmConnectStateChange);
    on<RealmMgmtUpdateSubscriptionsStarted>(_realmUpdateSubscriptions);
  }

  Future<void> _realmLoginStarted(RealmMgmtLoginRequested event, Emitter<RealmMgmtState> emit) async {
    try {
      final state = this.state;
      if (state.isLogin == true) {
        log("_realmLoginStarted is login");
        return;
      } else if (event.employeePOJO == null) {
        log("_realmUpdateSubscriptions is sync");
        throw IllegalArgumentException("_realmUpdateSubscriptions employeePOJO is empty");
      }

      emit(const RealmMgmtLoadInProgress(
        isLogin: false,
        isUpdateSubscriptions: false,
        isRealmConnect: false,
      ));

      await realmAuthorizedRepository.logIn();
      realmAuthorizedRepository.bindConnectionStreamListen(_connectionStream);
      realmAuthorizedRepository.bindUploadProgressStreamListen(_uploadProgressStream);
      realmAuthorizedRepository.bindDownloadProgressStreamListen(_downloadProgressStream);
      emit(RealmMgmtAuthenticatedSuccess(
          isLogin: true, isUpdateSubscriptions: false, isRealmConnect: false, employeePOJO: event.employeePOJO));
    } catch (e) {
      log('RealmLoginBloc _realmLoginStarted : ${e.toString()}');
      emit(const RealmMgmtLoadFailure(isLogin: false, isUpdateSubscriptions: false, isRealmConnect: false));
    }
  }

  Future<void> _realmLogoutStarted(RealmMgmtLogoutRequested event, Emitter<RealmMgmtState> emit) async {
    try {
      final state = this.state;
      if (state.isLogin == false) {
        log("_realmLogoutStarted not login");
        return;
      }
      await realmAuthorizedRepository.closeRealm();
      await realmAuthorizedRepository.logOut();
      emit(const RealmMgmtLogoutSuccess(
        isLogin: false,
        isUpdateSubscriptions: false,
        isRealmConnect: false,
      ));
    } catch (e) {
      log('RealmLoginBloc _realmLogoutStarted : ${e.toString()}');
      emit(const RealmMgmtLoadFailure(isLogin: false, isUpdateSubscriptions: false, isRealmConnect: false));
    }
  }

  void _realmConnectStateChange(RealmMgmtConnectStateChanged event, Emitter<RealmMgmtState> emit) {
    try {
      final state = this.state;
      emit(RealmMgmtAuthenticatedSuccess(
        isLogin: true,
        isUpdateSubscriptions: state.isUpdateSubscriptions,
        isRealmConnect: event.isConnected,
      ));
    } catch (e) {
      log('RealmLoginBloc _realmLogoutStarted : ${e.toString()}');
      emit(const RealmMgmtLoadFailure(isLogin: true, isUpdateSubscriptions: false, isRealmConnect: false));
    }
  }

  Future<void> _realmUpdateSubscriptions(
      RealmMgmtUpdateSubscriptionsStarted event, Emitter<RealmMgmtState> emit) async {
    emit(const RealmMgmtSubscriptionsLoadInProgress(
      isLogin: true,
      isUpdateSubscriptions: false,
      isRealmConnect: true,
    ));
    try {
      final state = this.state;
      if (state.isLogin == false) {
        log("_realmUpdateSubscriptions not login");
        throw IllegalArgumentException("_realmUpdateSubscriptions not login");
      } else if (state.isUpdateSubscriptions == true) {
        log("_realmUpdateSubscriptions is sync");
        return;
      }

      await realmAuthorizedRepository.updateSubscriptions(
          SubscriptionReq(event.employeePOJO.employeeId, event.employeePOJO.defaultDepartmentCode));

      emit(const RealmMgmtSubscriptionsUpdatedSuccess(
        isLogin: true,
        isUpdateSubscriptions: true,
        isRealmConnect: true,
      ));
    } catch (e) {
      log('RealmLoginBloc _realmLogoutStarted : ${e.toString()}');
      emit(const RealmMgmtLoadFailure(isLogin: true, isUpdateSubscriptions: false, isRealmConnect: false));
    }
  }

  void _connectionStream(ConnectionStateChange event) {
    log("===============ConnectionStateChange ${event.current.name}===============");

    if (event.current == ConnectionState.connected) {
      add(RealmMgmtConnectStateChanged(isConnected: true));
    }

    if (event.current == ConnectionState.disconnected) {
      add(RealmMgmtConnectStateChanged(isConnected: false));
    }
  }

  void _uploadProgressStream(SyncProgress event) {
    log("===============SyncProgress realmProgressUploadStream transferableBytes[${event.transferableBytes}], transferableBytes[${event.transferredBytes}]===============");
  }

  void _downloadProgressStream(SyncProgress event) {
    log("===============SyncProgress realmProgressDownloadStream transferableBytes[${event.transferableBytes}], transferableBytes[${event.transferredBytes}]===============");
  }
}
