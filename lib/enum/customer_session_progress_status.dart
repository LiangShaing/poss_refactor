/// TODO 暫時僅使用三個狀態
enum ProgressStatus {
  // created, //新增
  selling, //銷售中 (還沒成立CT)
  settlement, //結算車 (成立CT)
  // payment, //付款中
  // paid, //讀單中
  closed, //已關閉 (還沒成立CT時關閉會客)
}

extension ProgressStatusExtension on ProgressStatus {
  String get value {
    switch (this) {
    // case ProgressStatus.created:
    //   return "NEW";
      case ProgressStatus.selling:
        return "SELLING";
      case ProgressStatus.settlement:
        return "SETTLEMENT";
    // case ProgressStatus.payment:
    //   return "PAYMENT";
    // case ProgressStatus.paid:
    //   return "PAID";
      case ProgressStatus.closed:
        return "CLOSED";
      default:
        return "";
    }
  }
}
