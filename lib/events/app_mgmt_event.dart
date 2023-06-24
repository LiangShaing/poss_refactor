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
