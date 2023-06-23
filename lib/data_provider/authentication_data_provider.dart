import 'package:chowsangsang_enterprise_portal/service_factory.dart';

class AuthenticationDataProvider {
  AuthenticationDataProvider._();

  factory AuthenticationDataProvider.instance() {
    return AuthenticationDataProvider._();
  }

  OauthService oauthService = ServiceFactory.createOauth();
  UsersService usersService = ServiceFactory.createUsers();

  Future<bool> checkRefreshTokenExist() {
    return oauthService.checkRefreshTokenExists();
  }

  Future<String> getOauthURL() {
    return oauthService.getOauthURL();
  }

  String getLogoutURL() {
    return oauthService.getLogoutURL();
  }

  Future<bool> saveOauthToken(String code) {
    return oauthService.getOauthToken(code);
  }

  Future<String> getUserId() {
    return oauthService.getUserId();
  }

  Future<void> cleanOauth() {
    return oauthService.cleanOauth();
  }

  Future<bool> execRefreshToken() {
    return oauthService.execRefreshToken();
  }

  Future<bool> userVerified(String userId, String password) {
    return usersService.userVerify(userId, password);
  }
}
