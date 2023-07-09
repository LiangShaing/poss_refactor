import 'package:chowsangsang_enterprise_portal/service_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_mgmt_bloc.dart';
import 'package:mobile_poss_gp01/events/realm_mgmt_event.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/i18n/localizations.dart';
import 'package:mobile_poss_gp01/util/exception/exception.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';

mixin HandleExceptionEvent {
  ///重導向登入頁並清除router history
  logoutRedirect(BuildContext? context) async {
    if (context == null) {
      return;
    }
    context.read<RealmMgmtBloc>().add(RealmMgmtLogoutRequested());

    // Navigator.of(context).pop();
    // LogoutModel _logoutModel = LogoutModel();
    // await _logoutModel.logout(context, deleteDeviceToken: false);
    // MyNavigationService.pushReset(BaseRoute.loginPageRouteName, LoginPageArguments(isAutoLogin: false));
  }

  ///關掉Dialog
  closeDialog(BuildContext? context) {
    if (context == null) {
      return;
    }
    Navigator.of(context).pop();
  }

  ///取得api資料錯誤時的處理
  void handleException(e, BuildContext? context, {required String eventName, VoidCallback? callBack}) {
    switch (e.runtimeType) {
      case BadRequestException:
        BadRequestException badRequestException = e as BadRequestException;
        bool bln = badRequestException.errorCode.isEmpty;
        Logger.error(
            message:
                "BadRequestException[ $eventName ][ ${bln ? 'none' : badRequestException.errorCode} ] - ${e.message.isNotEmpty ? e.message : 'none'}");
        Future(() {
          _showMyDialog(context, (context) => closeDialog(context),
                  contentText: bln || badRequestException.errorCode.tr.isEmpty
                      ? "${"exception.msg.badRequestError".tr}${e.message.isNotEmpty ? "(${e.message})" : ""}"
                      : badRequestException.errorCode)
              .then((value) => callBack != null ? callBack() : null);
        });
        break;
      case InternalServerErrorException:
        Logger.error(message: "InternalServerErrorException[ $eventName ]");
        Future(() {
          _showMyDialog(context, (context) => closeDialog(context), contentText: "exception.msg.systemError".tr)
              .then((value) => callBack != null ? callBack() : null);
        });
        break;
      case ConflictException:
        Logger.error(message: "ConflictException[ $eventName ]");
        Future(() {
          _showMyDialog(context, (context) => closeDialog(context), contentText: "exception.msg.badRequestError".tr)
              .then((value) => callBack != null ? callBack() : null);
        });
        break;
      case UnauthorizedException:
        Logger.error(message: "UnauthorizedException[ $eventName ]");
        Future(() {
          _showMyDialog(context, (context) => logoutRedirect(context), contentText: "exception.msg.retryLogin".tr)
              .then((value) => callBack != null ? callBack() : null);
        });
        break;
      case ForbiddenException:
        Logger.error(message: "ForbiddenException[ $eventName ]");
        Future(() {
          _showMyDialog(context, (context) => closeDialog(context), contentText: "exception.msg.forbidden".tr)
              .then((value) => callBack != null ? callBack() : null);
        });
        break;
      case NotFoundException:
        Logger.error(message: "NotFoundException[ $eventName ]");
        Future(() {
          _showMyDialog(context, (context) => closeDialog(context), contentText: "exception.msg.resourcesNotFound".tr)
              .then((value) => callBack != null ? callBack() : null);
        });
        break;
      case NoInternetConnectionException:
        Logger.error(message: "NoInternetConnectionException[ $eventName ]");
        Future(() {
          _showMyDialog(context, (context) => closeDialog(context),
              contentText: "exception.msg.noInternetConnection".tr);
        }).then((value) => callBack != null ? callBack() : null);
        break;
      case IllegalArgumentException:
        Logger.error(message: "IllegalArgumentException[ $eventName ]");
        Future(() {
          _showMyDialog(context, (context) => closeDialog(context),
                  contentText: "exception.msg.illegalArgumentError".tr)
              .then((value) => callBack != null ? callBack() : null);
        });
        break;
      case DeadlineExceededException:
        Logger.error(message: "DeadlineExceededException[ $eventName ]");
        Future(() {
          _showMyDialog(context, (context) => closeDialog(context), contentText: "exception.msg.deadlineError".tr)
              .then((value) => callBack != null ? callBack() : null);
        });
        break;
      case GoneException:
        Logger.error(message: "GoneException[ $eventName ]");
        Future(() {
          _showMyDialog(context, (context) => closeDialog(context), contentText: "exception.msg.appVersionUpgrade".tr)
              .then((value) => callBack != null ? callBack() : null);
        });
        break;
      case RealmLoginFailedException:
        Logger.error(message: "RealmLoginFailedException[ $eventName ]");
        Future(() {
          _showMyDialog(context, (context) => closeDialog(context), contentText: "exception.msg.realmLoginFailed".tr)
              .then((value) => callBack != null ? callBack() : null);
        });
        break;
      default:
        Logger.error(message: "Exception[ $eventName ][ ${e.toString()}]");
        Future(() {
          _showMyDialog(context, (context) => closeDialog(context), contentText: "exception.msg.systemError".tr)
              .then((value) => callBack != null ? callBack() : null);
        });
        break;
    }
  }

  Future<void> _showMyDialog(BuildContext? context, Function event,
      {String title = "widget.dialog.title.message", String contentText = ''}) async {
    if (context == null) return;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.error_outline_outlined, color: Color.fromRGBO(238, 103, 60, 1), size: 24),
            ),
            Text(
              Translate.of(context).getLan(title),
              style: const TextStyle(fontSize: 16, color: Colors.black),
            )
          ]),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  contentText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Translate.of(context).getLan("widget.button.confirm")),
              onPressed: () {
                event(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialog(BuildContext context, String title, Function event, [String contentText = '']) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.error_outline_outlined, color: Color.fromRGBO(238, 103, 60, 1), size: 24),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            )
          ]),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  contentText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Translate.of(context).getLan("widget.button.confirm")),
              onPressed: () {
                event(context);
              },
            ),
          ],
        );
      },
    );
  }
}
