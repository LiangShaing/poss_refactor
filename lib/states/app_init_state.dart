import 'package:equatable/equatable.dart';

abstract class AppInitState<T> extends Equatable {
  const AppInitState({this.deviceId = ""});

  final String deviceId;
}

class AppInitLoadInProgress extends AppInitState {
  const AppInitLoadInProgress({super.deviceId});

  @override
  List<Object> get props => [];
}

class AppInitLoadFailure extends AppInitState {
  const AppInitLoadFailure({super.deviceId});

  @override
  List<Object> get props => [];
}

class AppInitDeepLinkCodeLoadSuccess extends AppInitState {
  final String code;

  const AppInitDeepLinkCodeLoadSuccess({super.deviceId, required this.code});

  @override
  List<Object> get props => [];
}
