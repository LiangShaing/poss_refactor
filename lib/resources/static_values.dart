import 'package:flutter/material.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/widgets/components/my_bottom_app_bar_stateless_widget.dart';

class StaticValues {
  static RegExp catalogItemCodeRegexp = RegExp(r'^[A-Za-z0-9]+-[A-Za-z0-9]+-[A-Za-z0-9]+$');

  static const List<String> saleTypes = ['store', 'remote'];

  static const List<EngravingFontOption> engravingFonts = [
    EngravingFontOption(name: 'Times 楷書', fontFamily: 'Times'),
    EngravingFontOption(name: 'Arial 楷書', fontFamily: 'Arial'),
    EngravingFontOption(name: 'Edwardian 楷書', fontFamily: 'Edwardian'),
  ];

  static const List<String> symbols = ['♥', '♡', '&'];

  static List<MyBottomAppBarItem> bottomAppBarNavigation = [
    const MyBottomAppBarItem(
      0,
      i18nName: "QR code",
      icon: Icons.qr_code,
    ),
    MyBottomAppBarItem(
      1,
      widget: Container(),
      // i18nName: "銷售交易",
      // icon: Icons.manage_search,
    ),
    MyBottomAppBarItem(
      2,
      widget: Container(),
      // i18nName: "金價匯率",
      // icon: Icons.shopping_cart,
    ),
    MyBottomAppBarItem(3, i18nName: "widget.myBottomAppBar.label.Transaction".tr, icon: Icons.manage_search),
    MyBottomAppBarItem(
      4,
      i18nName: "widget.myBottomAppBar.label.shoppingCart".tr,
      icon: Icons.shopping_cart,
    ),
  ];

  static const earmarkPurposeCode = "O2O";
}

class EngravingFontOption {
  final String name;
  final String fontFamily;

  const EngravingFontOption({
    required this.name,
    required this.fontFamily,
  });
}
