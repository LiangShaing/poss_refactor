import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_poss_gp01/resources/realm/model/customer_session.dart';
import 'package:realm/realm.dart';

class RealmDaoException implements Exception {
  final String message;

  RealmDaoException(this.message);

  @override
  String toString() {
    return message;
  }
}

class RealmSyncDao {
  static Realm? _realm;
  static App? _app;
  static User? _user;
  static Credentials? _credentials;
  static bool? _loginCheckNetworkStatus;
  // static RealmResults<CustomerSession>? customerSessionResults;

  RealmSyncDao._();

  factory RealmSyncDao.instance() {
    return RealmSyncDao._();
  }

  static void setAppId(String appId) {
    if (appId.isEmpty) {
      throw RealmDaoException("[setAppId]] appId is empty");
    }
    _app = App(AppConfiguration(appId));
  }

  static void setAnonymousCredentials() {
    _credentials = Credentials.anonymous();
  }

  static void setEmailPasswordCredentials(String email, String password) {
    if (email.isEmpty) {
      throw RealmDaoException("[setEmailPasswordCredentials] email is empty");
    } else if (password.isEmpty) {
      throw RealmDaoException("[setEmailPasswordCredentials] password is empty");
    }
    _credentials = Credentials.emailPassword(email, password);
  }

  static void setJwtCredentials(String token) {
    if (token.isEmpty) {
      throw RealmDaoException("[setJwtCredentials] token is empty");
    }
    _credentials = Credentials.jwt(token);
  }

  static void setApiKeyCredentials(String key) {
    if (key.isEmpty) {
      throw RealmDaoException("[setApiKeyCredentials] key is empty");
    }
    _credentials = Credentials.apiKey(key);
  }

  static void setNetworkCheck(bool status) {
    _loginCheckNetworkStatus = status;
  }

  static void setRealmName(String name) {
    if (name.isEmpty) {
      throw RealmDaoException("[setRealmName] name is empty");
    }
    Configuration.defaultRealmName = name;
  }

  static void setRealmPath(String path) {
    if (path.isEmpty) {
      throw RealmDaoException("[setRealmPath] path is empty");
    }
    Configuration.defaultRealmPath = path;
  }

  Realm get realm {
    if (_realm == null) {
      throw RealmDaoException("[getRealm] realm is null");
    }
    return _realm!;
  }

  Future<bool> isNetworkConnect() async {
    if (_loginCheckNetworkStatus == null || _loginCheckNetworkStatus == false) {
      return true;
    }
    final connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.none) ? false : true;
  }

  Future<User?> userLogin() async {
    if (_app == null) {
      throw RealmDaoException("[userLogin] app is null");
    } else if (_credentials == null) {
      throw RealmDaoException("[userLogin] login Credentials is null");
    }

    if (await isNetworkConnect() == false) {
      _log("[userLogin] network not connect");
      if (_app?.currentUser == null) {
        throw RealmDaoException("not find user");
      }
      _user = _app?.currentUser;
    } else {
      _log("[userLogin] network is connect");
      _user = await _app?.logIn(_credentials!);
    }
    _log("[userLogin] finish, user: ${_user?.id}");
    return _user;
  }

  Future<void> userLogout() async {
    await _user?.logOut();
    _user = null;
    _log("userLogout finish");
  }

  Future<void> createRealm() async {
    _log("[createRealm] start");
    if (_app == null) {
      throw RealmDaoException("[createRealm] realm _app is null");
    } else if (_user == null) {
      throw RealmDaoException("[createRealm] realm _user is null");
    }
    _log("[createRealm] path: ${Configuration.defaultRealmPath}");
    Configuration config = Configuration.flexibleSync(_user!, [
      /* CustomerSession */
      CustomerSession.schema,
      BrowsingHistories.schema,
      /* ShoppingBag */
      ShoppingBag.schema,
      ShoppingBagItem.schema,
      /* UIPersistShoppingBag */
      UIPersistShoppingBag.schema,
      CacheProductItem.schema,
      ProductDiscount.schema,
      CatalogItemTitle.schema,
      BookingUnit.schema,
      BookingUnitsCbu.schema,
    ], syncErrorHandler: (SyncError error) {
      _log("[createRealm][syncErrorHandler] Error message : ${error.message.toString()}");
    }, clientResetHandler: ManualRecoveryHandler((clientResetError) {
      _log("[createRealm][clientResetHandler] clientResetError.isFatal : ${clientResetError.isFatal}");
      _realm?.close();
      clientResetError.resetRealm();
    }));

    _realm = Realm(config);
    _log("[createRealm] finish, _realm.path: ${_realm?.config.path}");
  }

  Future<void> updateSubscriptions() async {
    if (_realm == null) {
      throw RealmDaoException("[updateSubscriptions] RealmSyncDao realm null");
    }

   final customerSessionResults = _realm?.query<CustomerSession>(
        r'departmentCode == $0 AND employeeId==$1 AND checkInIndicator == $2', ["689", "221470", true]);

    if (await isNetworkConnect() == false) {
      _log("[updateSubscriptions] not network.");
      return;
    }

    _realm?.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.clear();
      mutableSubscriptions.add(customerSessionResults!);
    });

    debugPrint("customerSessionResults.length ==================== ${customerSessionResults?.length}");
    await _realm?.subscriptions.waitForSynchronization();
  }

  static void deleteRealm(String path) {
    _log("[deleteRealm] path: $path");
    Realm.deleteRealm(path);
  }

  void closeRealm() {
    _realm?.close();
    _realm = null;
    _log("closeRealm finish");
  }

  static void _log(String message) {
    debugPrint(message);
  }
}
