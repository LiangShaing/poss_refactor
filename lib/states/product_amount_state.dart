import 'package:equatable/equatable.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_amount.dart';

abstract class ProductAmountState<T> extends Equatable {
  const ProductAmountState();
}

class ProductAmountLoadInProgress extends ProductAmountState {
  @override
  List<Object> get props => [];
}

class ProductAmountLoadInitial extends ProductAmountState {
  @override
  List<Object> get props => [];
}

class ProductAmountLoadSuccess extends ProductAmountState {
  final ProductAmount? productAmount;

  const ProductAmountLoadSuccess(this.productAmount);

  @override
  List<Object?> get props => [productAmount];
}

class ProductAmountLoadFailure extends ProductAmountState {
  const ProductAmountLoadFailure(this.errorMessage, {this.exception});

  final String errorMessage;
  final dynamic exception;

  @override
  List<Object> get props => [errorMessage, exception];
}
