abstract class AppInitEvent {}

class AppInitStarted extends AppInitEvent {}

class AppInitCASCodeReturned extends AppInitEvent {
  final String code;

  AppInitCASCodeReturned({required this.code}) : super();
}
