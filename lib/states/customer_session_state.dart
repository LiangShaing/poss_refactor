import 'package:equatable/equatable.dart';
import 'package:mobile_poss_gp01/realm/model/realm_models.dart';

abstract class CustomerSessionState<T> extends Equatable {
  const CustomerSessionState();
}

class CustomerSessionLoading extends CustomerSessionState {
  @override
  List<Object> get props => [];
}

class CustomerSessionLoaded extends CustomerSessionState {
  const CustomerSessionLoaded({this.customerSession =  CustomerSession()});

  final CustomerSession customerSession;

  @override
  List<Object> get props => [customerSession];
}

class CustomerSessionError extends CustomerSessionState {
  @override
  List<Object> get props => [];
}