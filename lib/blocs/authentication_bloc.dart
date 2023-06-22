import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deep_link/flutter_deep_link.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/enum/bloc_status.dart';
import 'package:mobile_poss_gp01/events/authentication_event.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/states/authentication_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';

class AuthenticationBloc extends AbstractBloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({required this.authenticationRepository}) : super(const AuthenticationState()) {
    on<AuthenticationInitialed>(_init);
    on<AuthenticationLoginRequested>(_login);
    on<AuthenticationLogoutRequested>(_logout);
  }

  /// 驗證登入狀態
  Future<void> _init(AuthenticationInitialed event, Emitter<AuthenticationState> emit) async {
    Logger.debug(message: "AuthenticationBloc _init");
    // 檢查refresh token 是否存在
    emit(state.copyWith(status: BlocStatus.loading));

    bool refreshTokenExist = await authenticationRepository.checkRefreshTokenExist();
    // if (!event.isAutoLogin && !refreshTokenExist) {
    //   return;
    // }

    if (!refreshTokenExist) {
      Logger.debug(message: "refreshToken not exist");
      Platform.isAndroid ? await _openBrowser() : await _openSafariService();
    } else {
      Logger.debug(message: "refreshToken exist");
      // await oauthService.execRefreshToken();
      // Logger.debug(message: "execRefreshToken successful");
      // userId = await oauthService.getUserId();

      // if (["PKCS12", "CRT"].contains(certificateVerify)) {
      //   //驗證憑證密碼
      //   NewRelicPlugin.loginRecord(
      //       className: "LoginPage", message: "Check OTP Success, with certificate [ $certificateVerify ]");
      //   Logger.debug(message: "Check OTP Success, with certificate [ $certificateVerify ]");
      //   String _certificatePwd = await ServiceFactory.getCertificatePwd();
      //   if (_certificatePwd.isEmpty) {
      //     NewRelicPlugin.loginRecord(
      //         className: "LoginPage", message: "verifyAuth with certificate but certificate password is empty");
      //     Logger.debug(message: "verifyAuth with certificate but certificate password is empty");
      //     throw UnauthorizedException(message: "verifyAuth with certificate but certificate password is empty");
      //   } else {
      //     await ServiceFactory.setCertificatePwd(_certificatePwd);
      //   }
      // }

      // // 已登入過OTP，判斷是否有生物辨識(加上前景才做生物辨識)，沒有則導向LDAP登入
      // Logger.debug(message: " _checkToBackground [ $_checkToBackground ],");
      // _loginType = LoginType.ldap;
    }

    // try {
    //   Logger.debug(message: "refreshTokenExist [ $refreshTokenExist ]");
    //   // NewRelicPlugin.loginRecord(
    //   //     className: "LoginPage",
    //   //     message: "verifyAuth fromLog [ $fromLog ], "
    //   //         "refreshTokenExist [ $refreshTokenExist ]");
    //   if (!refreshTokenExist) {
    //     //先將狀態登出
    //     _loginInfoModel.logout();
    //     Logger.debug(message: "refreshToken not exist");
    //     mounted ? setState(() => _isLoading = false) : null;
    //
    //     Platform.isAndroid ? await _openBrowser() : await _openSafariService();
    //   } else {
    //     Logger.debug(message: "refreshToken exist");
    //     await oauthService.execRefreshToken();
    //     Logger.debug(message: "execRefreshToken successful");
    //     userId = await oauthService.getUserId();
    //
    //     if (["PKCS12", "CRT"].contains(certificateVerify)) {
    //       //驗證憑證密碼
    //       NewRelicPlugin.loginRecord(
    //           className: "LoginPage", message: "Check OTP Success, with certificate [ $certificateVerify ]");
    //       Logger.debug(message: "Check OTP Success, with certificate [ $certificateVerify ]");
    //       String _certificatePwd = await ServiceFactory.getCertificatePwd();
    //       if (_certificatePwd.isEmpty) {
    //         NewRelicPlugin.loginRecord(
    //             className: "LoginPage", message: "verifyAuth with certificate but certificate password is empty");
    //         Logger.debug(message: "verifyAuth with certificate but certificate password is empty");
    //         throw UnauthorizedException(message: "verifyAuth with certificate but certificate password is empty");
    //       } else {
    //         await ServiceFactory.setCertificatePwd(_certificatePwd);
    //       }
    //     }
    //
    //     // 已登入過OTP，判斷是否有生物辨識(加上前景才做生物辨識)，沒有則導向LDAP登入
    //     Logger.debug(message: " _checkToBackground [ $_checkToBackground ],");
    //     _loginType = LoginType.ldap;
    //   }
    // } on PlatformException catch (error) {
    //   Logger.error(message: "LoginPage verifyAuth Exception:" + error.toString());
    //   throw PlatformException(code: 'oauth', message: 'verify refresh token error : ${error.message.toString()}');
    // } catch (e) {
    //   if (mounted) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //     handleException(e, context, eventName: "LoginPage verifyAuth");
    //   } else {
    //     //解決使用者登如時滑掉app導致setState未完成
    //     handleException(e, null, eventName: "LoginPage verifyAuth");
    //   }
    // } finally {
    //   Logger.debug(message: "LoginPage verifyAuth finally");
    //   mounted ? setState(() => {_loginType, _isLoading = false}) : null;
    // }
  }

  Future<void> _login(AuthenticationEvent event, Emitter<AuthenticationState> emit) async {}

  ///取得device id
  Future<void> _logout(AuthenticationEvent event, Emitter<AuthenticationState> emit) async {}

  ///Android打開瀏覽器
  Future<void> _openBrowser() async {
    Logger.debug(message: "LoginPage _openBrowser");
    // NewRelicPlugin.loginRecord(className: "LoginPage", message: "_openBrowser");
    //取得oauth 路徑
    String url = await authenticationRepository.getOauthURL();
    try {
      await FlutterDeepLink.openBrowser(url: url);
    } on PlatformException catch (error) {
      Logger.error(message: "LoginPage _openBrowser:$error");
    }
  }

  ///IOS打開瀏覽器
  Future<void> _openSafariService() async {
    Logger.debug(message: "LoginPage _openSafariService");
    // NewRelicPlugin.loginRecord(className: "LoginPage", message: "_openSafariService");
    //取得oauth 路徑
    String url = await authenticationRepository.getOauthURL();
    try {
      await FlutterDeepLink.openSafariService(url: url);
    } on PlatformException catch (error) {
      Logger.error(message: "LoginPage _openSafariService:$error");
    }
  }
}


