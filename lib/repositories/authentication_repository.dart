import 'package:mobile_poss_gp01/data_provider/authentication_data_provider.dart';

class AuthenticationRepository {
  AuthenticationDataProvider authenticationDataProvider = AuthenticationDataProvider.instance();

  Future<bool> checkRefreshTokenExist() {
    return authenticationDataProvider.checkRefreshTokenExist();
  }

  Future<String> getOauthURL() {
    return authenticationDataProvider.getOauthURL();
  }

  String getLogoutURL(){
    return authenticationDataProvider.getLogoutURL();
  }

  Future<bool> saveOauthToken(String code) {
    return authenticationDataProvider.saveOauthToken(code);
  }

  Future<String> getUserId() {
    return authenticationDataProvider.getUserId();
  }

  Future<Map<String, dynamic>> getTokenInfo(){
    return authenticationDataProvider.getTokenInfo();
  }

  Future<void> cleanOauth() {
    return authenticationDataProvider.cleanOauth();
  }

  Future<bool> execRefreshToken(){
    return authenticationDataProvider.execRefreshToken();
  }

  Future<bool> userVerified(String userId, String password){
    return authenticationDataProvider.userVerified(userId, password);
  }


}
