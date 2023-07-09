enum CTLineStatus {
  voided,
}

extension CTLineStatusExtension on CTLineStatus {
  String get value {
    switch (this) {
      case CTLineStatus.voided:
        return "VOIDED";

      default:
        return "";
    }
  }
}
