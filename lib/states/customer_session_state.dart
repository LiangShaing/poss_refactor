import 'package:equatable/equatable.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/customer_session.dart';

abstract class CustomerSessionState<T> extends Equatable {
  const CustomerSessionState();
}

class CustomerSessionLoadInitial extends CustomerSessionState {
  @override
  List<Object> get props => [];
}

class CustomerSessionInProgress extends CustomerSessionState {
  @override
  List<Object> get props => [];
}

class CustomerSessionLoadSuccess extends CustomerSessionState {
  const CustomerSessionLoadSuccess({this.customerSession});

  final CustomerSession? customerSession;

  @override
  List<Object?> get props => [customerSession];
}

class CustomerSessionLoadFailure extends CustomerSessionState {
  @override
  List<Object> get props => [];
}
