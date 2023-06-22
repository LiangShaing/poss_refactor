abstract class AuthenticationEvent {}

class AuthenticationInitialed extends AuthenticationEvent {
  final bool isAutoLogin;

  AuthenticationInitialed({this.isAutoLogin = false}) : super();
}

class AuthenticationLoginRequested extends AuthenticationEvent {
  final String code;

  AuthenticationLoginRequested({required this.code}) : super();
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
