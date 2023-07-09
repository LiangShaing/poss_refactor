import 'package:mobile_poss_gp01/data_provider/realm_data_provider.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';

class ShoppingBagDataProvider extends RealmDataProvider {
  Future<void> addItemToShoppingBag(CustomerSession customerSession, ShoppingBagItem shoppingBagItem) async {
    realmSyncDao.realm.write(() {
      customerSession.shoppingBag?.items.add(shoppingBagItem);
    });
  }
}
