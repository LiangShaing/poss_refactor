import 'package:chowsangsang_enterprise_portal/service_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/authentication_bloc.dart';
import 'package:mobile_poss_gp01/enum/bloc_status.dart';
import 'package:mobile_poss_gp01/events/authentication_event.dart';
import 'package:mobile_poss_gp01/events/realm_mgmt_event.dart';
import 'package:mobile_poss_gp01/routes/custom_page_route.dart';
import 'package:mobile_poss_gp01/states/authentication_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:mobile_poss_gp01/widgets/screens/login/login_screen.dart';

/// APP 背景事件處理
class AppLifeCycleManagerStatefulWidget extends StatefulWidget {
  final Widget child;

  const AppLifeCycleManagerStatefulWidget({Key? key, required this.child}) : super(key: key);

  @override
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<AppLifeCycleManagerStatefulWidget> with WidgetsBindingObserver {
  OauthService oauthService = ServiceFactory.createOauth();

  //憑證驗證
  // final bool _certificateVerifyToggle = certificateVerify.isNotEmpty;

  //紀錄app 背景前景狀態
  AppLifecycleState _appLifecycleState = AppLifecycleState.resumed;

  bool isLoading = false;

  @override
  void initState() {
    Logger.screen("AppLifeCycleManager");
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    // if (_certificateVerifyToggle) {
    //   NewRelicPlugin.loginRecord(className: "AppLifeCycleManager", message: "enabled certificate");
    //   Logger.debug(message: "enabled certificate");
    //   //讀取憑證檔
    //   Future(() async {
    //     try {
    //       ServiceFactory.setCertificateType(certificateVerify);
    //       if (certificateVerify == "PKCS12") {
    //         ByteData certificate = await rootBundle.load(certificatePKCS12Path);
    //         ServiceFactory.setCertificate(certificate);
    //       } else if (certificateVerify == "CRT") {
    //         ByteData certificate = await rootBundle.load(certificateCrtPath);
    //         ByteData certificateKey = await rootBundle.load(certificateKeyPath);
    //         ServiceFactory.setCertificate(certificate);
    //         ServiceFactory.setCertificateKey(certificateKey);
    //       }
    //     } catch (e) {
    //       Logger.error(message: "certificate is empty");
    //     }
    //   });
    // }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    Logger.screen("dispose AppLifeCycleManager");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.detached) {
      return;
    }
    final isBackground = state == AppLifecycleState.paused;

    // Logger.debug(
    //     message:
    //         "AppLifeCycleManager State[ $state ], login [ ${_loginInfoModel?.getLoginStatus} ], _loginInfoModel.getInLoginPage [ ${_loginInfoModel?.getInLoginPage} ],_appLifecycleState [ $_appLifecycleState ], getAccessAppPassedDateTime [ ${_loginInfoModel?.getAccessAppPassedDateTime} ]");
    // NewRelicPlugin.loginRecord(
    //     className: "AppLifeCycleManager",
    //     message:
    //     "State[ $state ], login [ ${_loginInfoModel?.getLoginStatus} ], _loginInfoModel.getInLoginPage [ ${_loginInfoModel?.getInLoginPage} ],_appLifecycleState [ $_appLifecycleState ], getAccessAppPassedDateTime [ ${_loginInfoModel?.getAccessAppPassedDateTime} ]");

    if (isBackground) {
      Logger.debug(message: "didChangeAppLifecycleState isBackground");
    } else {
      Logger.debug(message: "didChangeAppLifecycleState isForeground");
      // BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationInitialed());

      // //1.登入頁就不導登入頁
      // //2.判斷state狀態,是因為推播點擊,有時候只會觸發前景狀態,不會先有背景狀態在前景狀態
      // //3.新增:登入後保留5分鐘時間不檢查
      // bool _conditionAccessAppPassed = _loginInfoModel != null &&
      //     _loginInfoModel.getAccessAppPassedDateTime != null &&
      //     DateTime.now().isBefore(_loginInfoModel.getAccessAppPassedDateTime);
      // if ((_loginInfoModel != null && _loginInfoModel.getInLoginPage) ||
      //     _appLifecycleState == state ||
      //     _conditionAccessAppPassed) {
      //   _appLifecycleState = state;
      //   Logger.debug(message: "didChangeAppLifecycleState InLoginPage");
      //   return;
      // }
      //
      // bool refreshTokenExist = await oauthService.checkRefreshTokenExists();
      //
      // if (refreshTokenExist) {
      //   // try {
      //   //   startLoading(navigationKey.currentContext!);
      //   //   await oauthService.execRefreshToken();
      //   //   if (Provider.of<PossProvider?>(context, listen: false) != null) {
      //   //     await Provider.of<PossProvider?>(context, listen: false)!.realm.subscriptions.waitForSynchronization();
      //   //   }
      //   //   MyNavigationService.maybePop();
      //   //   Logger.debug(message: "waitForSynchronization completed");
      //   // } catch (e) {
      //   //   Logger.debug(message: "refresh token failed");
      //   //   NewRelicPlugin.loginRecord(className: "AppLifeCycleManager", message: "refresh token failed");
      //   //   MyNavigationService.maybePop();
      //   //   MyNavigationService.pushReset(
      //   //       BaseRoute.loginPageRouteName,
      //   //       LoginPageArguments(
      //   //         isInitDeepLink: false,
      //   //         isForeground: false,
      //   //         isAutoLogin: true,
      //   //       ));
      //   // }
      // } else {
      //   // MyNavigationService.pushReset(
      //   //     BaseRoute.loginPageRouteName,
      //   //     LoginPageArguments(
      //   //       isInitDeepLink: false,
      //   //       isForeground: false,
      //   //       isAutoLogin: true,
      //   //     ));
      // }
    }
    _appLifecycleState = state;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        /* 登入成功接續登入realm */
        // if (state.status == BlocStatus.initial && !state.inLoginScreen) {
        //   BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogoutRequested());
        //   SchedulerBinding.instance.addPostFrameCallback((_) {
        //     Navigator.push(context, CustomPageRoute(builder: (context) {
        //       return LoginScreen();
        //     }));
        //   });
        // }
      },
      child: Container(
        child: widget.child,
      ),
    );
  }
}
