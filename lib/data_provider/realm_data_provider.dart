import 'package:mobile_poss_gp01/database_objects/realm/realm_sync_dao.dart';

abstract class RealmDataProvider {
  RealmSyncDao realmSyncDao = RealmSyncDao.instance();
}
