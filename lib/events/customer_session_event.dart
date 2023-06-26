import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';

abstract class CustomerSessionEvent {}

class CustomerSessionInitialed extends CustomerSessionEvent {}

class CustomerSessionStarted extends CustomerSessionEvent {}

class CustomerSessionTerminated extends CustomerSessionEvent {}

class CustomerSessionPaused extends CustomerSessionEvent {}
