import 'package:equatable/equatable.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_amount.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_info.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/customer_session.dart';

abstract class ShoppingBagEvent extends Equatable {
  const ShoppingBagEvent();
}

class ShoppingBagStarted extends ShoppingBagEvent {
  @override
  List<Object> get props => [];
}

class ShoppingBagItemAdded extends ShoppingBagEvent {
  // const ShoppingBagItemAdded(this.item);
  //
  // final ShoppingBagItem item;

  final ProductInfo? productInfo;
  final ProductAmount productAmount;
  final bool isInventoryItem;
  final bool isModelItem;

  // final ProductItemO2OPOJO? productItemO2OPOJO;

  const ShoppingBagItemAdded({
    this.productInfo,
    required this.productAmount,
    this.isInventoryItem = false,
    this.isModelItem = false,
    // this.productItemO2OPOJO,
  });

  @override
  List<Object> get props => [];
}

class ShoppingBagItemRemoved extends ShoppingBagEvent {
  const ShoppingBagItemRemoved(this.item);

  final ShoppingBagItem item;

  @override
  List<Object> get props => [item];
}
