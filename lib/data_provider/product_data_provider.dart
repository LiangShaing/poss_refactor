import 'package:mobile_poss_gp01/data_provider/realm_data_provider.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:collection/collection.dart';

class ProductDataProvider extends RealmDataProvider {
  Earmark? findEarmarkByCatalogItem(String catalogItem) {
    return realmSyncDao.realm.query<Earmark>(r'catalogItem ==[c] $0', [catalogItem]).firstOrNull;
  }
}
