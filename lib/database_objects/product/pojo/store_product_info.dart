import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';

class StoreProductInfo {
  CatalogItem? catalogItem;
  Model? model;
  Inventory? inventory;
  Earmark? earmark;

  List<StoreProductInfo> storeCatalogItems;

  StoreProductInfo({this.catalogItem, this.model, this.inventory, this.earmark, this.storeCatalogItems = const []});

  bool get isInStore => catalogItem != null && model != null && inventory != null;
}
