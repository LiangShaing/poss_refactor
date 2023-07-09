import 'package:mobile_poss_gp01/database_objects/product/pojo/product_amount.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_info.dart';

class AddToCartReq {
  final ProductInfo? productInfo;
  final ProductAmount productAmount;
  final bool isInventoryItem;
  final bool isModelItem;

  // final ProductItemO2OPOJO? productItemO2OPOJO;
  final List<String> imagesPath;

  const AddToCartReq(
      {this.productInfo,
      required this.productAmount,
      this.isInventoryItem = false,
      this.isModelItem = false,
      // this.productItemO2OPOJO,
      this.imagesPath = const []});
}
