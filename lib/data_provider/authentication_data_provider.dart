import 'package:chowsangsang_enterprise_portal/service_factory.dart';

class AuthenticationDataProvider {
  AuthenticationDataProvider._();

  factory AuthenticationDataProvider.instance() {
    return AuthenticationDataProvider._();
  }

  OauthService oauthService = ServiceFactory.createOauth();

  Future<bool> checkRefreshTokenExist() {
    return oauthService.checkRefreshTokenExists();
  }

  Future<String> getOauthURL() {
    return oauthService.getOauthURL();
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

  Future<bool> execRefreshToken(){
    return oauthService.execRefreshToken();

  }
}
