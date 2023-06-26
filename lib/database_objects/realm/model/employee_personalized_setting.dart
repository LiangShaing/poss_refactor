import 'package:realm/realm.dart';

part 'generated/employee_personalized_setting.g.dart';

@RealmModel()
@MapTo('employeePersonalizedSetting')
class _EmployeePersonalizedSetting {
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;
  late String employeeId;
  late String? employeeName;
  late String? departmentCode;
  late DateTime? lastLoginDate;
  late String? deviceId;
}