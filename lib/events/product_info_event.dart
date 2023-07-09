import 'package:mobile_poss_gp01/database_objects/product/pojo/store_product.dart';

abstract class ProductInfoEvent {}

class ProductInitialed extends ProductInfoEvent {}

class StoreProductInfoProgressed extends ProductInfoEvent {
  final StoreProduct storeProduct;

  StoreProductInfoProgressed({required this.storeProduct}) : super();
}
