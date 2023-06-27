import 'package:mobile_poss_gp01/data_provider/realm_data_provider.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';
import 'package:realm/realm.dart';

class CustomerSessionDataProvider extends RealmDataProvider {
  RealmResults<CustomerSession> findCurrentCustomerSessionByEmployee(EmployeePOJO employeePOJO) {
    return realmSyncDao.realm.query<CustomerSession>(
        r'departmentCode == $0 AND employeeId==$1 AND checkInIndicator == $2',
        [employeePOJO.defaultDepartmentCode, employeePOJO.employeeId, true]);
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
}
