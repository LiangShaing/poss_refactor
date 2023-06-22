import 'package:flutter/material.dart';
import 'package:mobile_poss_gp01/resources/color_style.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';


appThemeData(BuildContext context) {
  return ThemeData(
    colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.black),
    hintColor: ColorStyle.grey,
    scaffoldBackgroundColor: ColorStyle.pageBackground,
    fontFamily: 'Noto Sans SC',
    fontFamilyFallback: const ['Noto Sans SC', 'Noto Sans TC'],
    primaryColor: ColorStyle.primary,
    appBarTheme: AppBarTheme.of(context).copyWith(color: ColorStyle.appbar),
    checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(ColorStyle.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        fillColor: MaterialStateProperty.resolveWith((states) {
          const Set<MaterialState> interactiveStates = <MaterialState>{
            MaterialState.pressed,
            MaterialState.hovered,
            MaterialState.focused,
            MaterialState.selected,
          };
          if (states.contains(MaterialState.disabled)) return ColorStyle.grey;
          if (states.any(interactiveStates.contains)) return ColorStyle.primary;
          return ColorStyle.grey;
        })),
    disabledColor: ColorStyle.disabled,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(side: MaterialStateProperty.resolveWith((states) {
        Color _color = ColorStyle.primary;
        if (states.contains(MaterialState.disabled)) _color = ColorStyle.lightGrey2;
        return BorderSide(width: 1, color: _color);
      })).merge(OutlinedButton.styleFrom(
        disabledBackgroundColor: ColorStyle.white,
        disabledForegroundColor: ColorStyle.lightGrey2,
        foregroundColor: ColorStyle.primary,
        backgroundColor: ColorStyle.white,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        minimumSize: SizeStyle.dialogButtonSize,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit),
      )),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: SizeStyle.dialogButtonSize,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.all(0.0),
        )),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          backgroundColor: ColorStyle.primary,
          minimumSize: SizeStyle.dialogButtonSize,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit),
        )),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused,
          MaterialState.selected,
        };
        if (states.contains(MaterialState.disabled)) return ColorStyle.grey;
        if (states.any(interactiveStates.contains)) return ColorStyle.primary;
        return ColorStyle.grey;
      }),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 32.0, color: ColorStyle.textColorMain, fontWeight: FontWeight.bold, height: SizeStyle.fontHeight),
      displayMedium: TextStyle(
          fontSize: 22.0, color: ColorStyle.textColorMain, fontWeight: FontWeight.bold, height: SizeStyle.fontHeight),
      displaySmall: TextStyle(
          fontSize: 20.0, color: ColorStyle.textColorMain, fontWeight: FontWeight.bold, height: SizeStyle.fontHeight),
      headlineMedium: TextStyle(
          fontSize: 18.0, color: ColorStyle.textColorMain, fontWeight: FontWeight.bold, height: SizeStyle.fontHeight),
      headlineSmall: TextStyle(
          fontSize: 16.0, color: ColorStyle.textColorMain, fontWeight: FontWeight.bold, height: SizeStyle.fontHeight),
      titleLarge: TextStyle(
          fontSize: 14.0, color: ColorStyle.textColorMain, fontWeight: FontWeight.bold, height: SizeStyle.fontHeight),
      titleMedium: TextStyle(
          fontSize: 12.0, color: ColorStyle.textColorMain, fontWeight: FontWeight.bold, height: SizeStyle.fontHeight),
      titleSmall: TextStyle(
          fontSize: 10.0, color: ColorStyle.textColorMain, fontWeight: FontWeight.bold, height: SizeStyle.fontHeight),
      bodyLarge: TextStyle(fontSize: 14.0, color: ColorStyle.textColorMain, height: SizeStyle.fontHeight),
      bodyMedium: TextStyle(fontSize: 12.0, color: ColorStyle.textColorMain, height: SizeStyle.fontHeight),
      bodySmall: TextStyle(
          fontSize: 10.0, color: ColorStyle.textColorMain, fontWeight: FontWeight.bold, height: SizeStyle.fontHeight),
    ),
  );
}
