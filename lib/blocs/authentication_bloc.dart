import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deep_link/flutter_deep_link.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/enum/bloc_status.dart';
import 'package:mobile_poss_gp01/events/authentication_event.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/states/authentication_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';

class AuthenticationBloc extends AbstractBloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({required this.authenticationRepository}) : super(const AuthenticationState()) {
    on<AuthenticationInitialed>(_init);
    on<AuthenticationLoginRequested>(_login);
    on<AuthenticationLDAPLoginRequested>(_ldapLogin);
    on<AuthenticationLogoutRequested>(_logout);
    on<AuthenticationLDAPPasswordChanged>(_inputLDAPPassword);
  }

  /// 驗證登入狀態
  Future<void> _init(AuthenticationInitialed event, Emitter<AuthenticationState> emit) async {
    Logger.debug(message: "AuthenticationBloc _init");
    // 檢查refresh token 是否存在
    emit(state.copyWith(status: BlocStatus.loading));

    bool refreshTokenExist = await authenticationRepository.checkRefreshTokenExist();
    if (!refreshTokenExist) {
      Logger.debug(message: "refreshToken not exist");
      emit(state.copyWith(status: BlocStatus.initial));
      Platform.isAndroid ? await _openBrowser() : await _openSafariService();
    } else {
      Logger.debug(message: "refreshToken exist");

      try {
        bool bln = await authenticationRepository.execRefreshToken();
        emit(state.copyWith(
            status: BlocStatus.success, refreshTokenExisted: true, accessTokenExisted: true, ldapVerified: true));
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
      } catch (e) {
        Logger.debug(message: "execRefreshToken unsuccessful");
        add(AuthenticationLogoutRequested());
      }
    }
  }

  Future<void> _login(AuthenticationLoginRequested event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));

    bool value = await authenticationRepository.saveOauthToken(event.code);

    if (value) {
      Logger.debug(message: "get oauth token success");
      // NewRelicPlugin.loginRecord(className: "LoginPage", message: "get oauth token success");
      String userId = await authenticationRepository.getUserId();
      Logger.debug(message: "_oauthTokenEndpoint  UserId: $userId");
      // NewRelicPlugin.userId(userId: userId);
      emit(state.copyWith(status: BlocStatus.loading, refreshTokenExisted: true, accessTokenExisted: true));
    } else {
      Logger.debug(message: "get oauth token unsuccessful");
      add(AuthenticationLogoutRequested());
    }
  }

  void _inputLDAPPassword(AuthenticationLDAPPasswordChanged event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(status: BlocStatus.initial, ldapPassword: event.password));
  }

  Future<void> _ldapLogin(AuthenticationLDAPLoginRequested event, Emitter<AuthenticationState> emit) async {
    // NewRelicPlugin.loginRecord(className: "LoginPage", message: "_ldapLogin");
    Logger.debug(message: "_ldapLogin");
    try {
      if (state.ldapPassword.isEmpty) {
        Logger.debug(message: "_ldapLogin ldapPassword isEmpty");
        emit(state.copyWith(
            status: BlocStatus.failure,
            refreshTokenExisted: true,
            accessTokenExisted: false,
            error: "base.login.msg.textFieldRequired".tr,
            ldapVerified: true));
      } else {
        Logger.debug(message: "_ldapLogin [${state.ldapPassword}]");
        emit(state.copyWith(status: BlocStatus.loading, refreshTokenExisted: true, accessTokenExisted: false));
        //驗證ldap
        String userId = await authenticationRepository.getUserId();
        bool value = await authenticationRepository.userVerified(userId, state.ldapPassword);
        if (value) {
          Logger.debug(message: "verify LDAP successful");
          emit(state.copyWith(status: BlocStatus.loading, refreshTokenExisted: true, accessTokenExisted: true));
        } else {
          emit(state.copyWith(
              status: BlocStatus.failure,
              refreshTokenExisted: true,
              accessTokenExisted: false,
              error: "base.login.msg.pwdUnsuccessful".tr,
              ldapVerified: true,
              ldapPassword: ''));
        }
      }
    } catch (error) {
      emit(state.copyWith(
          status: BlocStatus.failure,
          refreshTokenExisted: true,
          accessTokenExisted: false,
          error: error.toString(),
          ldapVerified: true,
          ldapPassword: ''));
    } finally {
      if (state.status == BlocStatus.failure) {
        emit(state.copyWith(status: BlocStatus.initial, error: ''));
      }
    }
  }

  ///取得device id
  Future<void> _logout(AuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    await authenticationRepository.cleanOauth();
    _logoutOpenBrowser();
    emit(state.copyWith(
        status: BlocStatus.initial,
        refreshTokenExisted: false,
        accessTokenExisted: false,
        error: '',
        ldapVerified: false));
  }

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

  ///登出開啟瀏覽器
  Future<void> _logoutOpenBrowser() async {
    String url = authenticationRepository.getLogoutURL();
    Logger.debug(message: "_logout url $url");
    try {
      if (Platform.isAndroid) {
        await FlutterDeepLink.openBrowser(url: url);
      } else if (Platform.isIOS) {
        await FlutterDeepLink.openSafariService(url: url);
      }
    } on PlatformException catch (error) {
      Logger.error(message: "LogoutModel _logout:$error");
    }
  }
}
