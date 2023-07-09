import 'package:equatable/equatable.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_amount.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_info.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/store_product.dart';

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

class ProductStoreLoadSuccess extends ProductState {
  // final ProductInfo productInfo;
  final StoreProduct storeProduct;

  const ProductStoreLoadSuccess(this.storeProduct);

  @override
  List<Object?> get props => [];
}

class ProductRemotedLoadSuccess extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadFailure extends ProductState {
  const ProductLoadFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
