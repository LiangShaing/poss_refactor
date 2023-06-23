abstract class AppMgmtEvent {}

class AppMgmtInitialed extends AppMgmtEvent {}

class AppMgmtCASCodeReturned extends AppMgmtEvent {
  final String code;

  AppMgmtCASCodeReturned({required this.code}) : super();
}

class AppMgmtDrawerShowed extends AppMgmtEvent {
  AppMgmtDrawerShowed() : super();
}

class AppMgmtDrawerClosed extends AppMgmtEvent {
  AppMgmtDrawerClosed() : super();
}
