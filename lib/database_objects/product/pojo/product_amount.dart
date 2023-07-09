import 'package:chowsangsang_enterprise_portal/service_factory.dart';

class ProductAmount{
  double? inventoryAmount;
  double? netAmount;
  PossSingleDiscount? selectedDiscount;
  List<PossSingleDiscount> discounts;
  double? goldPrice;

  ProductAmount(this.inventoryAmount, this.netAmount, this.selectedDiscount, this.discounts, this.goldPrice);
}