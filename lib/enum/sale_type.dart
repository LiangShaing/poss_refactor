enum SaleType {
  inStore,
  remoted,
}

extension SaleTypeExtension on SaleType {
  String get value {
    switch (this) {
      case SaleType.inStore:
        return "in-store";
      case SaleType.remoted:
        return "remote";

      default:
        return "";
    }
  }
}
