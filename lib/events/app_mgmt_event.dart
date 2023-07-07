import 'dart:ui';

abstract class AppMgmtEvent {}

class AppMgmtInitialed extends AppMgmtEvent {}

class AppMgmtOauthCodeReturned extends AppMgmtEvent {
  final String code;

  AppMgmtOauthCodeReturned({required this.code}) : super();
}

class AppMgmtDrawerOpened extends AppMgmtEvent {
  AppMgmtDrawerOpened() : super();
}

class AppMgmtDrawerClosed extends AppMgmtEvent {
  AppMgmtDrawerClosed() : super();
}

class AppMgmtLocalizationChanged extends AppMgmtEvent {
  final Locale locale;

  AppMgmtLocalizationChanged({required this.locale});

  List<Object> get props => [locale];
}
