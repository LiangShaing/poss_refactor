import 'package:mobile_poss_gp01/data_provider/realm_data_provider.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';
import 'package:realm/realm.dart';

class CustomerSessionDataProvider extends RealmDataProvider {
  RealmResults<CustomerSession> findCurrentCustomerSessionByEmployee(Employee employee) {
    DateTime current = DateTime.now().toUtc();
    return realmSyncDao.realm.query<CustomerSession>(
        r'departmentCode == $0 AND employeeId==$1 AND checkInIndicator == $2 AND createdDate >= $3', [
      employee.defaultDepartmentCode,
      employee.employeeId,
      true,
      DateTime.utc(current.year, current.month, current.day, 00, 00, 00)
    ]);
  }

  Future<void> createCustomerSession(CustomerSession customerSession) async {
    realmSyncDao.realm.write(() {
      realmSyncDao.realm.add(customerSession);
    });
  }

  Future<void> closeCustomerSession(CustomerSession customerSession) async {
    realmSyncDao.realm.write(() {
      customerSession.checkInIndicator = false;
    });
  }

  Future<void> createBrowsingHistories(CustomerSession customerSession, BrowsingHistories browsingHistories) async {
    realmSyncDao.realm.write(() {
      customerSession.browsingHistories.add(browsingHistories);
    });
  }
}
