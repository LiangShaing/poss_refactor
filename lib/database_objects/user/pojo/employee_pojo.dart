class Employee {
  String name;
  String employeeId;
  String defaultDepartmentCode;
  List<Department> departments;

  Employee(this.name, this.employeeId, this.defaultDepartmentCode, this.departments);

  Employee.clone(Employee ori)
      : this(
          ori.name,
          ori.employeeId,
          ori.defaultDepartmentCode,
          ori.departments,
        );
}

class Department {
  String name;
  String role;
  String code;

  Department(this.name, this.role, this.code);

  Department.clone(Department ori)
      : this(
          ori.name,
          ori.role,
          ori.code,
        );
}
