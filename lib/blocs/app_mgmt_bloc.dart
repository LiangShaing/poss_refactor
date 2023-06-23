import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deep_link/flutter_deep_link.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/events/app_init_event.dart';
import 'package:mobile_poss_gp01/states/app_mgmt_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';

class AppMgmtBloc extends AbstractBloc<AppMgmtEvent, AppMgmtState> {
  AppMgmtBloc() : super(const AppMgmtLoadInProgress()) {
    on<AppMgmtInitialed>(_appInit);
    on<AppMgmtCASCodeReturned>(_deepLinkCodeReturned);
  }

  Future<void> _appInit(AppMgmtEvent event, Emitter<AppMgmtState> emit) async {
    String deviceId = await _getDeviceId();
    if (deviceId.isEmpty) {
      emit(const AppMgmtLoadFailure());
    }
    _initHandleDeepLink();
  }

  Future<void> _deepLinkCodeReturned(AppMgmtCASCodeReturned event, Emitter<AppMgmtState> emit) async {
    Logger.debug(message: "_deepLinkCodeReturned [${event.code}]");
    emit(AppMgmtDeepLinkCodeLoadSuccess(code: event.code));
  }

  ///取得device id
  Future<String> _getDeviceId() async {
    String deviceId = "";
    Logger.debug(message: "_getDeviceId");
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      deviceId = await const AndroidId().getId() ?? 'Unknown ID';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor ?? "Unknown ID";
    }
    // NewRelicPlugin.loginRecord(className: "LoginPage", message: "_getDeviceId exist [ ${_deviceId.isNotEmpty} ]");
    if (deviceId.isEmpty) {
      Logger.error(message: "LoginPage device id is empty");
    }
    Logger.debug(message: "DeviceId : $deviceId");
    // deviceService.setDeviceId(_deviceId);
    return deviceId;
  }

  /// 初始化deep link function
  void _initHandleDeepLink() {
    Logger.debug(message: "_initHandleDeepLink");
    // NewRelicPlugin.loginRecord(className: "LoginPage", message: "_initHandleDeepLink");
    FlutterDeepLink.streamDeepLinkResult?.listen((deepLink) {
      add(AppMgmtCASCodeReturned(code: _urlParser(deepLink)));
    });
  }

  /// Oauth登入完成後執行
  String _urlParser(String deepLink) {
    Logger.debug(message: "_urlParser: $deepLink");
    // NewRelicPlugin.loginRecord(
    //     className: "LoginPage", message: "_urlParser, _isOpenBrowserStatus: $_isOpenBrowserStatus");
    Uri uri = Uri.parse(deepLink);
    // 取得從CAS回來的code
    String code = uri.queryParameters['code'] ?? "";
    return code;
  }
}
