

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
  @override
  List<Object> get props => [];
}
