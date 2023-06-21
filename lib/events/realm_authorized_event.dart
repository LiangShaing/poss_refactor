abstract class RealmAuthorizedEvent {
  List<Object> get props => [];
}

class RealmLoginStarted extends RealmAuthorizedEvent {}

class RealmUpdateSubscriptionsStarted extends RealmAuthorizedEvent {}

class RealmLogoutStarted extends RealmAuthorizedEvent {}

class RealmConnectStateChange extends RealmAuthorizedEvent {
  final bool isConnected;

  RealmConnectStateChange({required this.isConnected});

  @override
  List<Object> get props => [isConnected];
}

class RealmUpdateSubscriptions extends RealmAuthorizedEvent {}
