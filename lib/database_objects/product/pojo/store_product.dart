import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';

class StoreProduct {
  CatalogItem? catalogItem;
  Model? model;
  Inventory? inventory;
  Earmark? earmark;

  List<StoreProduct> storeCatalogItems;

  StoreProduct({this.catalogItem, this.model, this.inventory, this.earmark, this.storeCatalogItems = const []});

  bool get isInStore => catalogItem != null && model != null && inventory != null;
}
