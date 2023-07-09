import 'package:equatable/equatable.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';

abstract class ShoppingBagState extends Equatable {
  const ShoppingBagState();
}

class ShoppingBagLoadInitial extends ShoppingBagState {
  @override
  List<Object> get props => [];
}

class ShoppingBagLoadInProgress extends ShoppingBagState {
  @override
  List<Object> get props => [];
}

class ShoppingBagLoadSuccess extends ShoppingBagState {
  const ShoppingBagLoadSuccess({required this.shoppingBag});

  final ShoppingBag shoppingBag;

  @override
  List<Object> get props => [shoppingBag];
}

class ShoppingBagLoadFailure extends ShoppingBagState {
  @override
  List<Object> get props => [];
}

class ShoppingBagItemAddInProgress extends ShoppingBagState {
  @override
  List<Object> get props => [];
}

class ShoppingBagItemAddSuccess extends ShoppingBagState {
  const ShoppingBagItemAddSuccess();

  @override
  List<Object> get props => [];
}

class ShoppingBagItemAddFailure extends ShoppingBagState {
  const ShoppingBagItemAddFailure(this.errorMessage, {this.exception});

  final String errorMessage;
  final dynamic exception;

  @override
  List<Object> get props => [errorMessage, exception];
}
