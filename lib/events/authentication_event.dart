abstract class AuthenticationEvent {}

class AuthenticationInitialed extends AuthenticationEvent {
  final bool isAutoLogin;

  AuthenticationInitialed({this.isAutoLogin = false}) : super();
}

class AuthenticationLoginRequested extends AuthenticationEvent {}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
