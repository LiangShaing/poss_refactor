import 'package:mobile_poss_gp01/data_provider/product_data_provider.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/store_product_info.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:realm/realm.dart';

class ProductRepository {
  ProductDataProvider dataProvider = ProductDataProvider();

  Earmark? findEarmarkByCatalogItem(String catalogItem) {
    return dataProvider.findEarmarkByCatalogItem(catalogItem);
  }

  StoreProductInfo getProductItemByItemNumberOrInventoryId(String value, Employee employee) {
    try {
      /* 在本店搜尋商品 */
      Inventory? inventory = dataProvider.findInventoryByItemNumberOrInventoryId(value, employee);
      Model? model = dataProvider.findModelByModelSequenceNumber(inventory?.modelSequenceNumber ?? 0);
      CatalogItem? catalogItem = dataProvider.findCatalogItemByCatalogItem(model?.catalogItem ?? "");

      Earmark? earmark;
      if (inventory != null && model != null && catalogItem != null) {
        /* 本店有此商品 */
        earmark = dataProvider.findEarmarkByModelSequenceNumber(model.modelSequenceNumber);
      }
      Logger.info(
          className: "ProductRepository",
          event: "getProductItemFromSearch",
          message:
              "ItemNumber,inventoryId [$value] departmentCode [${employee.defaultDepartmentCode}] : Inventory[${inventory?.id}] Model[${model?.id}] CatalogItem[${catalogItem?.id}] Earmark [${earmark?.quantity}]");
      return StoreProductInfo(catalogItem: catalogItem, model: model, inventory: inventory, earmark: earmark);
    } catch (e) {
      Logger.error(className: "ProductRepository", event: "getProductItemFromSearch", message: e.toString());
      rethrow;
    }
  }

  List<StoreProductInfo> getProductItemFromStoreByCatalogItem(String value, Employee employee) {
    List<StoreProductInfo> result = [];
    /* 在本店搜尋catalogItem商品 */
    List<Inventory> inventories = dataProvider.findInventoriesByCatalogItem(value, employee);
    for (Inventory e in inventories) {
      Model? model = dataProvider.findModelByModelSequenceNumber(e.modelSequenceNumber);
      CatalogItem? catalogItem = dataProvider.findCatalogItemByCatalogItem(model?.catalogItem ?? "");
      if (model != null && catalogItem != null) {
        result.add(StoreProductInfo(catalogItem: catalogItem, model: model, inventory: e));
      }
    }

    return result;
  }
}
