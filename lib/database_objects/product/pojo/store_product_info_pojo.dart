import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';

class StoreProductInfoPOJO {
  CatalogItem catalogItem;
  Model model;
  Inventory inventory;
  Earmark? earmark;

  List<StoreProductInfoPOJO> storeCatalogItems;
  StoreProductInfoPOJO({required this.catalogItem,required this.model,required this.inventory, this.earmark, this.storeCatalogItems = const []});

  // bool get isInStore => catalogItem != null && model != null && inventory != null;
}
