import 'package:equatable/equatable.dart';

abstract class AppMgmtState<T> extends Equatable {
  const AppMgmtState({this.deviceId = ""});

  final String deviceId;
}

class AppMgmtLoadInProgress extends AppMgmtState {
  const AppMgmtLoadInProgress({super.deviceId});

  @override
  List<Object> get props => [];
}

class AppMgmtLoadFailure extends AppMgmtState {
  const AppMgmtLoadFailure({super.deviceId});

  @override
  List<Object> get props => [];
}

class AppMgmtDeepLinkCodeLoadSuccess extends AppMgmtState {
  final String code;

  const AppMgmtDeepLinkCodeLoadSuccess({super.deviceId, required this.code});

  @override
  List<Object> get props => [];
}
