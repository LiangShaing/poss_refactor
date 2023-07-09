import 'package:mobile_poss_gp01/database_objects/product/pojo/product_info.dart';

abstract class ProductAmountEvent {}

class ProductAmountFetched extends ProductAmountEvent {
  final ProductInfo productInfo;

  ProductAmountFetched({required this.productInfo}) : super();
}
