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

class AuthenticationLDAPLoginRequested extends AuthenticationEvent {
  AuthenticationLDAPLoginRequested() : super();
}

class AuthenticationLDAPPasswordChanged extends AuthenticationEvent {
  final String password;

  AuthenticationLDAPPasswordChanged({required this.password}) : super();
}

class AuthenticationLoginScreenLeaved extends AuthenticationEvent {
  AuthenticationLoginScreenLeaved() : super();
}
