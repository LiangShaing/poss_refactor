import 'package:flutter/material.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/resources/color_style.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';

///共用方法
mixin CommonFunction {
  Future<void> startLoading(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const SimpleDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent, // can change this to your prefered color
          children: <Widget>[
            Center(
              child: CircularProgressIndicator(),
            )
          ],
        );
      },
    );
  }

  Future<void> stopLoading(BuildContext context) async {
    Navigator.of(context).pop();
  }

  /// 彈跳視窗
  /// @param context 所需參數
  /// @param title 標題文字
  /// @param content 內容文字
  /// @param btnText 按鈕文字
  Future<void> showAlert(
      BuildContext context,
      String title, {
        String? content,
        String btnText = '',
        TextAlign titleAlignment = TextAlign.start,
        TextAlign contentAlignment = TextAlign.start,
        Icon icon = const Icon(Icons.error_outline_outlined, color: Color.fromRGBO(238, 103, 60, 1), size: 24),
        VoidCallback? callback,
      }) async {
    String _finalBtnText = btnText.isNotEmpty ? btnText : "widget.button.back".tr;
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) => AlertDialog(
        title: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: icon,
          ),
          Text(title, style: const TextStyle(fontSize: 16, color: Colors.black), textAlign: titleAlignment)
        ]),
        content: content != null
            ? Text(content, style: Theme.of(context).textTheme.bodyMedium, textAlign: contentAlignment)
            : null,
        actions: <Widget>[
          TextButton(
            child: Text(_finalBtnText),
            onPressed: callback ?? () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  /// 彈跳視窗 (確認是否送出申請單)
  /// @param context 所需參數
  Future<bool> showSubmitDialog(BuildContext context) async {
    bool _isSubmit = false;
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.error_outline_outlined, color: Color.fromRGBO(238, 103, 60, 1), size: 24),
            ),
            Text("widget.submitDialog.msg.checkSubmit".tr,
                style: const TextStyle(fontSize: 16, color: Colors.black))
          ]),
          actions: <Widget>[
            TextButton(
              child: Text("widget.submitDialog.button.modify".tr),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("widget.submitDialog.button.submit".tr),
              onPressed: () {
                _isSubmit = true;
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    return _isSubmit;
  }

  /// 彈跳視窗(選項)
  /// @param context 所需參數
  /// @param title 標題文字
  /// @param content 內容文字
  /// @param btnTextFalse(return false) 按鈕文字
  /// @param btnTextTrue(return true) 按鈕文字
  Future<bool?> showAlertWithResp(BuildContext context, String title,
      {String? content,
        String? btnTextFalse = '',
        String btnTextTrue = '',
        TextAlign titleAlignment = TextAlign.start,
        TextAlign contentAlignment = TextAlign.start}) async {
    String? _finalBtnTextFalse = btnTextFalse == null
        ? null
        : btnTextFalse.isNotEmpty
        ? btnTextFalse
        : "widget.button.back".tr;
    String _finalBtnTextTrue =
    btnTextTrue.isNotEmpty ? btnTextTrue : "widget.button.confirm".tr;
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) => AlertDialog(
        title: Column(children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Icon(Icons.error_outline_outlined, color: Color.fromRGBO(238, 103, 60, 1), size: 24),
          ),
          Text(title, style: const TextStyle(fontSize: 16, color: Colors.black), textAlign: titleAlignment)
        ]),
        content: content != null
            ? Text(content, style: Theme.of(context).textTheme.bodyMedium, textAlign: contentAlignment)
            : null,
        actions: <Widget>[
          if (_finalBtnTextFalse != null)
            TextButton(
              child: Text(_finalBtnTextFalse),
              onPressed: () => Navigator.pop(context, false),
            ),
          TextButton(
            child: Text(_finalBtnTextTrue),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }

  /// 彈跳視窗(選項)
  /// @param context 所需參數
  /// @param content 內容文字
  /// @param btnTextFalse(return false) 按鈕文字
  /// @param btnTextTrue(return true) 按鈕文字
  Future<bool?> showAlertThemeListWithResp(BuildContext context, List<Widget> content,
      {String btnTextFalse = '', String btnTextTrue = ''}) async {
    String _finalBtnTextFalse =
    btnTextFalse.isNotEmpty ? btnTextFalse : "widget.button.back".tr;
    String _finalBtnTextTrue =
    btnTextTrue.isNotEmpty ? btnTextTrue : "widget.button.confirm".tr;
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) => AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: content,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(_finalBtnTextFalse),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text(_finalBtnTextTrue),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }

  Future<T?> showMyDialogWithScaffold<T>({
    required BuildContext context,
    required Widget body,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
  }) async {
    return await showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
      builder: (context) => ScaffoldMessenger(
        child: Builder(builder: (context) => Scaffold(backgroundColor: Colors.transparent, body: body)),
      ),
    );
  }

  void showErrorSnackBar(BuildContext context, String message, {SnackBarAction? snackBarAction}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: ColorStyle.warningRed.withOpacity(0.8),
      duration: snackBarAction == null ? const Duration(milliseconds: 1200) : const Duration(milliseconds: 4000),
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.3,
        right: MediaQuery.of(context).size.width * 0.3,
        bottom: SizeStyle.paddingUnit * 2,
      ),
      content: Center(child: Text(message)),
      action: snackBarAction,
    ));
  }

  void showSuccessSnackBar(BuildContext context, String message, {SnackBarAction? snackBarAction}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: ColorStyle.black.withOpacity(0.8),
      duration: snackBarAction == null ? const Duration(milliseconds: 1200) : const Duration(milliseconds: 4000),
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.3,
        right: MediaQuery.of(context).size.width * 0.3,
        bottom: SizeStyle.paddingUnit * 2,
      ),
      content: Center(child: Text(message)),
      action: snackBarAction,
    ));
  }
}
