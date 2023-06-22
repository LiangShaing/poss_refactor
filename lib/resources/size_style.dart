import 'package:flutter/material.dart';

class SizeStyle {
  /// alert icon size
  static const double alertIconSize = 24;

  /// 文字行高
  static const double fontHeight = 1.5;

  /// padding最小單位
  static const double paddingUnit = 8;

  /* paddings of pages */
  static const double pagePadding = paddingUnit * 2;

  /* app bar size */
  static const Size topAppBarSize = Size.fromHeight(60);
  static const double bottomAppBarHeight = 60;

  /// 畫面分左右欄位時，右方欄位固定寬
  static const double fixedColumnWidth = 228;

  /* customerSession 固定長寬 */
  static const double customerSessionWidth = 767;
  static const double customerSessionHeight = 480;

  /* dialog 預設寬度 */
  static const double dialogWidth = 520;
  static const double dialogHeightRatio = 0.6;

  /* button size */
  static const double buttonHeightMedium = 36;
  static const double buttonHeightLarge = 50;
  static const double buttonWidthSmall = 60;
  static const double buttonWidthMedium = 80;

  /// theme button size (60*36)
  static const Size themeButtonSize = Size(buttonWidthSmall, buttonHeightMedium);

  /// dialog button size (80*36)
  static const Size dialogButtonSize = Size(buttonWidthMedium, buttonHeightMedium);

  /// large button size (double infinity*50)
  static const Size largeButtonSize = Size.fromHeight(buttonHeightLarge);

  static const Radius radius = Radius.circular(5);

  static BorderRadius borderRadius = BorderRadius.circular(5);
}
