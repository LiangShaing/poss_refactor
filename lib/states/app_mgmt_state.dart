import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:mobile_poss_gp01/enum/bloc_status.dart';

class AppMgmtState extends Equatable {
  const AppMgmtState(
      {this.deviceId = "",
      this.drawer = true,
      this.locale = const Locale('zh', 'CN'),
      this.status = BlocStatus.initial})
      : super();

  final String deviceId;
  final Locale? locale;
  final bool drawer;
  final BlocStatus status;

  @override
  List<Object?> get props => [deviceId, drawer, locale, status];

  AppMgmtState copyWith({String? deviceId, String? code, bool? drawer, Locale? locale, BlocStatus? status}) {
    return AppMgmtState(
        deviceId: deviceId ?? this.deviceId,
        drawer: drawer ?? this.drawer,
        locale: locale ?? this.locale,
        status: status ?? this.status);
  }
}

class AppMgmtDeepLinkCodeLoadSuccess extends AppMgmtState {
  final String code;

  const AppMgmtDeepLinkCodeLoadSuccess({super.deviceId, required this.code}) : super();

  @override
  List<Object> get props => [code];
}
