class EmployeePOJO {
  String name;
  String employeeId;
  String defaultDepartmentCode;
  List<DepartmentPOJO> departments;

  EmployeePOJO(this.name, this.employeeId, this.defaultDepartmentCode, this.departments);

  EmployeePOJO.clone(EmployeePOJO ori)
      : this(
          ori.name,
          ori.employeeId,
          ori.defaultDepartmentCode,
          ori.departments,
        );
}

class DepartmentPOJO {
  String name;
  String role;
  String code;

  DepartmentPOJO(this.name, this.role, this.code);

  DepartmentPOJO.clone(DepartmentPOJO ori)
      : this(
          ori.name,
          ori.role,
          ori.code,
        );
}
