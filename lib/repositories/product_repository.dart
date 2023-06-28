import 'package:mobile_poss_gp01/data_provider/product_data_provider.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:realm/realm.dart';

class ProductRepository {
  ProductDataProvider dataProvider = ProductDataProvider();

  Earmark? findEarmarkByCatalogItem(String catalogItem) {
    return dataProvider.findEarmarkByCatalogItem(catalogItem);
  }

  // ProductInfoRes getProductItemFromStoreByItemNumberOrInventoryId(String value) {
  //   ObjectId? _inventoryId;
  //   ObjectId? _modelId;
  //   ObjectId? _catalogItemId;
  //   try {
  //
  //     /* 在本店搜尋商品 */
  //     Inventory? _inventory = realmService.realm.query<Inventory>(
  //         r'itemNumber LIKE[c] $0 OR inventoryId == $1 AND custodianDepartmentCode == $2',
  //         ["$value*", value, realmService.possEmployees?.defaultDepartmentCode]).firstOrNull;
  //     _inventoryId = _inventory?.id;
  //     Model? _model =
  //         realmService.realm.query<Model>(r'modelSequenceNumber == $0', [_inventory?.modelSequenceNumber]).firstOrNull;
  //     _modelId = _model?.id;
  //     CatalogItem? _catalogItem =
  //         realmService.realm.query<CatalogItem>(r'catalogItem == $0', [_model?.catalogItem]).firstOrNull;
  //     _catalogItemId = _catalogItem?.id;
  //
  //     Earmark? _earmark;
  //     if (_inventory != null && _model != null && _catalogItem != null) {
  //       /* 本店有此商品 */
  //       _earmark = realmService.realm
  //           .query<Earmark>(r'modelSequenceNumber ==[c] $0', [_model.modelSequenceNumber]).firstOrNull;
  //     }
  //     realmService.loggerNewRelicInfo("getProductItemFromSearch",
  //         "ItemNumber,inventoryId [$value] departmentCode [${realmService.possEmployees?.defaultDepartmentCode}] : Inventory[${_inventory?.id}] Model[${_model?.id}] CatalogItem[${_catalogItem?.id}] Earmark [${_earmark?.quantity}]");
  //     return ProductInfoRes(catalogItem: _catalogItem, model: _model, inventory: _inventory, earmark: _earmark);
  //   } catch (e) {
  //     Logger.error(className:"ProductRepository",message: '');
  //     realmService.loggerNewRelicError("getProductItemFromSearch",
  //         "ItemNumber,inventoryId [$value] departmentCode [${realmService.possEmployees?.defaultDepartmentCode}] : Inventory[$_inventoryId] Model[$_modelId] CatalogItem[$_catalogItemId] ");
  //     rethrow;
  //   }
  // }

}
