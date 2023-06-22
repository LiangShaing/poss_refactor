import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/events/app_init_event.dart';
import 'package:mobile_poss_gp01/states/app_init_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';

class AppInitBloc extends AbstractBloc<AppInitEvent, AppInitState> {
  AppInitBloc() : super(const AppInitLoadInProgress()) {
    on<AppInitStarted>(_appInit);
  }
}

Future<void> _appInit(AppInitEvent event, Emitter<AppInitState> emit) async {
  String deviceId = await _getDeviceId();
  if (deviceId.isEmpty) {
    emit(const AppInitLoadFailure());
  }
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
