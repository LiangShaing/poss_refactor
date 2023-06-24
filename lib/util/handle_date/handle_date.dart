import 'package:intl/intl.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';

class HandleDate {
  /// 取得format後的時間 yyyy年mm月dd日 上午/下午 hh:mm
  static String getFormattedDate(DateTime dateTime) {
    String updateDateStr = dateTime.toIso8601String();
    DateTime updateDate = DateTime.parse(updateDateStr);
    DateFormat formatter = DateFormat(
        "${"menu.label.update".tr}: yyyy${"menu.label.year".tr}MM${"menu.label.month".tr}dd${"menu.label.day".tr} a HH:mm");
    RegExp amRegex = RegExp(r'AM', caseSensitive: false);
    RegExp pmRegex = RegExp(r'PM', caseSensitive: false);
    String updateDateFormatted = formatter
        .format(updateDate)
        .replaceAll(amRegex, "menu.label.dateAM".tr)
        .replaceAll(pmRegex, "menu.label.datePM".tr);

    return updateDateFormatted;
  }
}
