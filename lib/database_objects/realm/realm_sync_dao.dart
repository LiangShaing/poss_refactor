import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:mobile_poss_gp01/database_objects/realm/pojo/subscription_req.dart';
import 'package:mobile_poss_gp01/resources/static_values.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
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
      Logger.info(className: "RealmSyncDao", event: "userLogin", message: "network not connect");
      if (_app?.currentUser == null) {
        throw RealmDaoException("not find user");
      }
      _user = _app?.currentUser;
    } else {
      Logger.info(className: "RealmSyncDao", event: "userLogin", message: "network is connect");
      _user = await _app?.logIn(_credentials!);
    }
    Logger.info(className: "RealmSyncDao", event: "userLogin", message: "finish user: ${_user?.id}");

    return _user;
  }

  Future<void> userLogout() async {
    await _user?.logOut();
    _user = null;
    Logger.info(className: "RealmSyncDao", event: "userLogout", message: "userLogout finish");
  }

  Future<void> createRealm() async {
    Logger.info(className: "RealmSyncDao", event: "createRealm", message: "start");

    if (_app == null) {
      throw RealmDaoException("[createRealm] realm _app is null");
    } else if (_user == null) {
      throw RealmDaoException("[createRealm] realm _user is null");
    }
    Logger.info(className: "RealmSyncDao", event: "createRealm", message: "path: ${Configuration.defaultRealmPath}");

    Configuration config = Configuration.flexibleSync(_user!, [
      /* PersonalizedSettings */
      //TODO:個人化設定 單一登入還未實作
      // EmployeePersonalizedSetting.schema,
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
      /* GoldRate */
      GoldRate.schema,
      /* CatalogItem */
      CatalogItem.schema,
      Reference.schema,
      Collection.schema,
      ProductSampleInfoObject.schema,
      ProductTagType.schema,
      /* Inventory */
      Inventory.schema,
      Bom.schema,
      Weight.schema,
      InventoryReference.schema,
      InventoryCertificates.schema,
      BomCertificate.schema,
      /* Model */
      Model.schema,
      ModelReference.schema,
      ProductTitle.schema,
      /* Earmark */
      Earmark.schema,
      /* PaymentMethod */
      PaymentMethod.schema,
      /* PaymentDevice */
      PaymentDevice.schema,
    ], syncErrorHandler: (SyncError error) {
      Logger.error(className: "RealmSyncDao", event: "createRealm", message: "${error.message}");
    }, clientResetHandler: ManualRecoveryHandler((clientResetError) {
      Logger.error(
          className: "RealmSyncDao",
          event: "createRealm",
          message: "clientResetError.isFatal : ${clientResetError.isFatal}");
      _realm?.close();
      clientResetError.resetRealm();
    }));

    _realm = Realm(config);
    Logger.info(
        className: "RealmSyncDao", event: "createRealm", message: "finish, _realm.path: ${_realm?.config.path}");
  }

  Future<void> updateSubscriptions(SubscriptionReq subscriptionReq) async {
    if (_realm == null) {
      throw RealmDaoException("[updateSubscriptions] RealmSyncDao realm null");
    }

    if (await isNetworkConnect() == false) {
      Logger.info(className: "RealmSyncDao", event: "updateSubscriptions", message: " not network.");
      return;
    }

    String departmentCode = subscriptionReq.defaultDepartmentCode;
    String employeeId = subscriptionReq.employeeId;

    final customerSessionResults = _realm?.query<CustomerSession>(
        r'departmentCode == $0 AND employeeId==$1 AND checkInIndicator == $2', [departmentCode, employeeId, true]);
    Logger.debug(
        message:
            "customerSessionResults query:[departmentCode == $departmentCode AND employeeId==$employeeId AND checkInIndicator == true]");
    final inventoryResults = realm.query<Inventory>(r'custodianDepartmentCode == $0', [departmentCode]);
    final modelResults = realm.query<Model>(r"departmentCodes == $0", [departmentCode]);
    final catalogItemResults = realm.query<CatalogItem>(r'departmentCodes == $0', [departmentCode]);

    final earmarkResults =
        realm.query<Earmark>(r'tag ==[c] $0 AND purposeCode ==[c] $0', [StaticValues.earmarkPurposeCode]);
    final shoppingBagResults = realm.query<ShoppingBag>(r'departmentCode == $0', [departmentCode]);

    final paymentMethodResults = realm.query<PaymentMethod>(r'departmentCode == $0', [departmentCode]);

    final paymentDeviceResults = realm.query<PaymentDevice>(r'departmentCode == $0', [departmentCode]);

    _realm?.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.clear();
      mutableSubscriptions.add(customerSessionResults!);
      mutableSubscriptions.add(_realm!.all<GoldRate>());
      mutableSubscriptions.add(inventoryResults);
      mutableSubscriptions.add(modelResults);
      mutableSubscriptions.add(catalogItemResults);
      mutableSubscriptions.add(earmarkResults);
      mutableSubscriptions.add(shoppingBagResults);
      mutableSubscriptions.add(paymentMethodResults);
      mutableSubscriptions.add(paymentDeviceResults);
    });

    debugPrint("customerSessionResults.length ==================== ${customerSessionResults?.length}");
    debugPrint("CatalogItem ===================== ${catalogItemResults.length}");
    debugPrint("Model ===================== ${modelResults.length}");
    debugPrint("Inventory ===================== ${inventoryResults.length}");
    debugPrint("PaymentMethod =====================${paymentMethodResults.length}");
    debugPrint("PaymentDevice =====================${paymentDeviceResults.length}");
    debugPrint("Earmark =====================${earmarkResults.length}");
    debugPrint("ShoppingBag =====================${shoppingBagResults.length}");
    await _realm?.subscriptions.waitForSynchronization();
  }

  static void deleteRealm(String path) {
    Logger.info(className: "RealmSyncDao", event: "deleteRealm", message: "path: $path");
    Realm.deleteRealm(path);
  }

  void closeRealm() {
    _realm?.close();
    _realm = null;
    Logger.info(className: "RealmSyncDao", event: "closeRealm", message: "finish");
  }
}
