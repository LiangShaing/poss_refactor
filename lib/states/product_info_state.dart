import 'package:equatable/equatable.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_amount.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_info.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/store_product.dart';

abstract class ProductInfoState<T> extends Equatable {
  const ProductInfoState();
}

class ProductInfoLoadInProgress extends ProductInfoState {
  @override
  List<Object> get props => [];
}

class ProductInfoLoadInitial extends ProductInfoState {
  @override
  List<Object> get props => [];
}

class ProductInfoLoadSuccess extends ProductInfoState {
  final ProductInfo productInfo;

  const ProductInfoLoadSuccess(this.productInfo);

  @override
  List<Object?> get props => [];
}

class ProductInfoLoadFailure extends ProductInfoState {
  const ProductInfoLoadFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
