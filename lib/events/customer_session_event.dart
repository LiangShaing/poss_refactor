
abstract class CustomerSessionEvent {}

class CustomerSessionStarted extends CustomerSessionEvent {}

class CustomerSessionTerminated extends CustomerSessionEvent {}

class CustomerSessionPaused extends CustomerSessionEvent {}