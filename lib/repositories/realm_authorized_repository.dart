import 'dart:async';

import 'package:mobile_poss_gp01/repositories/repository.dart';
import 'package:realm/realm.dart';

class RealmAuthorizedRepository extends RealmRepository {
  StreamSubscription? _realmConnectStream;
  StreamSubscription? _realmUploadProgressStream;
  StreamSubscription? _realmDownloadProgressStream;

  Future<void> logIn() async {
    await realmSyncDao.userLogin();
    await realmSyncDao.createRealm();
  }

  Future<void> closeRealm() async {
    _realmConnectStream?.cancel();
    _realmUploadProgressStream?.cancel();
    _realmDownloadProgressStream?.cancel();
    _realmConnectStream = null;
    _realmUploadProgressStream = null;
    _realmDownloadProgressStream = null;
    realmSyncDao.closeRealm();
  }

  Future<void> logOut() async {
    await realmSyncDao.userLogout();
  }

  Future<void> updateSubscriptions() async {
    await realmSyncDao.updateSubscriptions();
  }

  void bindConnectionStreamListen(callbackFun) {
    _realmConnectStream?.cancel();
    _realmConnectStream = realmSyncDao.realm.syncSession.connectionStateChanges.listen(callbackFun);
  }

  void bindUploadProgressStreamListen(callbackFun) {
    _realmUploadProgressStream?.cancel();
    _realmUploadProgressStream = realmSyncDao.realm.syncSession
        .getProgressStream(ProgressDirection.upload, ProgressMode.forCurrentlyOutstandingWork)
        .listen(callbackFun);
  }

  void bindDownloadProgressStreamListen(callbackFun) {
    _realmDownloadProgressStream?.cancel();
    _realmDownloadProgressStream = realmSyncDao.realm.syncSession
        .getProgressStream(ProgressDirection.download, ProgressMode.forCurrentlyOutstandingWork)
        .listen(callbackFun);
  }
}
