class SubscriptionReq {
  String employeeId;
  String defaultDepartmentCode;

  SubscriptionReq(this.employeeId, this.defaultDepartmentCode);

  SubscriptionReq.clone(SubscriptionReq ori)
      : this(
          ori.employeeId,
          ori.defaultDepartmentCode,
        );
}
