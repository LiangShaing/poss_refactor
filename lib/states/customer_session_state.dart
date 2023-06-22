import 'package:equatable/equatable.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/customer_session.dart';

abstract class CustomerSessionState<T> extends Equatable {
  const CustomerSessionState();
}

class CustomerSessionInitial extends CustomerSessionState {
  @override
  List<Object> get props => [];
}

class CustomerSessionLoading extends CustomerSessionState {
  @override
  List<Object> get props => [];
}

class CustomerSessionLoaded extends CustomerSessionState {
  const CustomerSessionLoaded({this.customerSession});

  final CustomerSession? customerSession;

  @override
  List<Object?> get props => [customerSession];
}

class CustomerSessionError extends CustomerSessionState {
  @override
  List<Object> get props => [];
}
