
abstract class CustomerSessionEvent {}

class CustomerSessionInitialed extends CustomerSessionEvent {}

class CustomerSessionStarted extends CustomerSessionEvent {}

class CustomerSessionTerminated extends CustomerSessionEvent {}

class CustomerSessionPaused extends CustomerSessionEvent {}
