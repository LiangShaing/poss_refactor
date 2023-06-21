
abstract class CustomerSessionEvent {}

class CustomerSessionSearched extends CustomerSessionEvent {}

class CustomerSessionStarted extends CustomerSessionEvent {}

class CustomerSessionTerminated extends CustomerSessionEvent {}

class CustomerSessionPaused extends CustomerSessionEvent {}
