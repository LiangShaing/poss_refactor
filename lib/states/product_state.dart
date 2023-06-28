import 'package:equatable/equatable.dart';

abstract class ProductState<T> extends Equatable {
  const ProductState();
}

class ProductLoadInProgress extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadFailure extends ProductState {
  const ProductLoadFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
