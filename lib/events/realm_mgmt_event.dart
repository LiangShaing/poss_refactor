abstract class RealmMgmtEvent {
  List<Object> get props => [];
}

class RealmMgmtLoginRequested extends RealmMgmtEvent {}

class RealmMgmtUpdateSubscriptionsStarted extends RealmMgmtEvent {}

class RealmMgmtLogoutRequested extends RealmMgmtEvent {}

class RealmMgmtConnectStateChanged extends RealmMgmtEvent {
  final bool isConnected;

  RealmMgmtConnectStateChanged({required this.isConnected});

  @override
  List<Object> get props => [isConnected];
}

// class RealmUpdateSubscriptions extends RealmMgmtEvent {}
