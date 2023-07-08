import 'package:mobile_poss_gp01/data_provider/realm_data_provider.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:collection/collection.dart';
import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';

class ProductDataProvider extends RealmDataProvider {
  Earmark? findEarmarkByCatalogItem(String value) {
    return realmSyncDao.realm.query<Earmark>(r'catalogItem ==[c] $0', [value]).firstOrNull;
  }

  Earmark? findEarmarkByModelSequenceNumber(double value) {
    return realmSyncDao.realm.query<Earmark>(r'modelSequenceNumber ==[c] $0', [value]).firstOrNull;
  }

  Inventory? findInventoryByItemNumberOrInventoryId(String value, Employee employee) {
    return realmSyncDao.realm.query<Inventory>(
        r'itemNumber LIKE[c] $0 OR inventoryId == $1 AND custodianDepartmentCode == $2',
        ["$value*", value, employee.defaultDepartmentCode]).firstOrNull;
  }

  List<Inventory> findInventoriesByCatalogItem(String value, Employee employee) {
    return realmSyncDao.realm.query<Inventory>(
        r'catalogItem ==[c] $0 AND custodianDepartmentCode == $1', [value, employee.defaultDepartmentCode]).toList();
  }

  Model? findModelByModelSequenceNumber(double value) {
    return realmSyncDao.realm.query<Model>(r'modelSequenceNumber == $0', [value]).firstOrNull;
  }

  CatalogItem? findCatalogItemByCatalogItem(String value) {
    return realmSyncDao.realm.query<CatalogItem>(r'catalogItem == $0', [value]).firstOrNull;
  }
}
