import 'package:intl/intl.dart';

class HandlePrice {
  static String formatPrice(num price, {int fixed = 0}) {
    if (fixed < 0) throw ArgumentError('fixed must be non-negative');

    String pattern = '#,###';
    if (fixed > 0) pattern += '.${'0' * fixed}';

    return NumberFormat(pattern).format(price);
  }

  static num sum(Iterable<num?> list) => list.reduce((a, b) => ((a ?? 0).toDouble() + (b ?? 0).toDouble())) ?? 0;
}
