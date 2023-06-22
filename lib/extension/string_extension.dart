import 'package:mobile_poss_gp01/i18n/localizations.dart';
import 'package:mobile_poss_gp01/main.dart';

extension StringExtension on String {
  ///i18N用
  String get tr {
    if (navigationKey.currentContext != null) {
      return Translate.of(navigationKey.currentContext!).getLan(this);
    }
    return "";
  }

  ///i18N用(填入參數)
  String trFill(List<String> list) {
    if (navigationKey.currentContext != null) {
      return Translate.of(navigationKey.currentContext!).getLan(this, list);
    }
    return "";
  }
}
