import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';


/// 語系 languageCode_scriptCode_countryCode
///
/// languageCode : 語言 中文與簡體: zh , 特別語系 yue_Hans_TW(IOS 簡體粵語),wuu_Hans_TW(IOS 上海話簡體)
///
/// scriptCode : 中文 繁體:Hant,簡體:Hans ,只有在中文的時候有值
///
/// countryCode : 地區
///
class Translate {

  const Translate(this._locale);

  final Locale _locale;

  static const defaultLocale = Locale.fromSubtags(languageCode: "zh",countryCode: "CN"); //預設語言

  static Map<String, Map<String ,String>> localizedValues = {}; //語系資料

  static List<Locale> supportLocale = [];

  static const LocalizationsDelegate<Translate> delegate = TranslateDelegate();

  static Translate of(BuildContext context) {
    return Localizations.of<Translate>(context, Translate)!;
  }

  ///讀取預設語系
  Future<void> loadDefaultLanguage() async {
    String _locale = defaultLocale.toLanguageTag();
    String _path = "assets/i18n/$_locale.json";
    try{
      if(localizedValues.containsKey(_locale)) return;
      String jsonString = await rootBundle.loadString(_path);
      Map<String, dynamic> map =  json.decode(jsonString);
      localizedValues.addAll({ _locale : map.map((key, value) => MapEntry(key, value.toString())) });
    }catch(error){
      Logger.error(message: "Translate.loadDefaultLanguage() error: ${error.toString()}");
    }
  }

  ///依手機語系,讀取json資料
  Future<void> loadLanguage() async {
    String locale = _locale.toLanguageTag();
    String path = "assets/i18n/$locale.json";
    try{
      if(localizedValues.containsKey(locale)) return;
      String jsonString = await rootBundle.loadString(path);
      Map<String, dynamic> map =  json.decode(jsonString);
      localizedValues.addAll({ locale : map.map((key, value) => MapEntry(key, value.toString())) });
    }catch(error){
      await loadDefaultLanguage();
      Logger.error(message: "Translate.loadLanguage() error: ${error.toString()}");
    }
  }

  ///取得語系文字
  String getLan(String key, [List<String> args = const []]) {
    if(localizedValues.isEmpty){
      Logger.error(message: "Translate.getLan() localizedValues is empty");
      return "";
    }
    String locale = (localizedValues.containsKey(_locale.toLanguageTag())) ? _locale.toLanguageTag() : defaultLocale.toLanguageTag();
    Map<String, String> _map = localizedValues[locale] ?? {};
    if(_map.isEmpty){
      Logger.error(message: "Translate.getLan() $locale : isEmpty");
      return "";
    }else if(!_map.containsKey(key)){
      Logger.error(message: "Translate.getLan() $locale : not find key($key)");
      return "";
    }
    String finalStr = _map[key]!;
    if (args.isNotEmpty) {
      args.asMap().forEach((index, value) => finalStr = finalStr.replaceAll("{$index}", value));
    }
    return finalStr;
  }

  ///語系 List<String> cover Locale
  static Locale getLocaleFromLocaleString(String localeName) {
    List<String> list = localeName.replaceAll("_", "-").split("-");
    Locale locale = defaultLocale;
    if(list.length < 2){
      return locale;
    }

    /*
      /// ios 不支援 wuu,yue語系
      String _check = "${list[0]}_${list[1]}";
      if(["wuu_Hans","yue_Hans"].contains(_check)){
        return const Locale.fromSubtags(languageCode: "zh",countryCode: "CN");
      }else
     */

    if(list.length==2){
      return Locale.fromSubtags(
          languageCode: list[0],
          countryCode: list[1]);
    }else if (list.length==3){
      return Locale.fromSubtags(
          languageCode: list[0],
          scriptCode: list[1],
          countryCode: list[2]);
    }
    return locale;
  }

  ///取得手機語系
  static Locale get getPlatformLocaleName {
    Logger.debug(message: "Translate Platform.localeName: ${Platform.localeName}");
    // NewRelicPlugin.i18n(message: "Platform.localeName: ${Platform.localeName}");
    return getLocaleFromLocaleString(Platform.localeName);
  }

  ///取得語系支持
  static Future<void> getSupportLocale() async {
    String path = "lib/i18n/support_locale.json";
    supportLocale.add(defaultLocale);
    try{
      String jsonString = await rootBundle.loadString(path);
      List<dynamic> map = json.decode(jsonString);
      for (var localeName in map) {
        Locale locale = getLocaleFromLocaleString(localeName);
        if(locale == defaultLocale) {
          continue;
        } else if(supportLocale.contains(locale)) {
          continue;
        }
        supportLocale.add(locale);
      }
    }catch(error){
      Logger.error(message: "Translate.getSupportLocale() error:  ${error.toString()}");
    }

  }
}

class TranslateDelegate extends LocalizationsDelegate<Translate> {

  const TranslateDelegate();

  @override
  bool isSupported(Locale locale) =>
      Translate.supportLocale.contains(locale) ? true : false;

  @override
  Future<Translate> load(Locale locale) async {
    Logger.debug(message: "TranslateDelegate.load() locale ${locale.toLanguageTag()}");
    // NewRelicPlugin.i18n(message: "locale ${locale.toLanguageTag()}");
    // ServiceFactory.setLanguage(locale.toString());
    Translate localizations = Translate(locale);
    await localizations.loadLanguage();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<Translate> old) => true;

}
