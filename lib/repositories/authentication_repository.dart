import 'package:mobile_poss_gp01/data_provider/authentication_data_provider.dart';

class AuthenticationRepository {
  AuthenticationDataProvider authenticationDataProvider = AuthenticationDataProvider.instance();

  Future<bool> checkRefreshTokenExist() {
    return authenticationDataProvider.checkRefreshTokenExist();
  }

  Future<String> getOauthURL() {
    return authenticationDataProvider.getOauthURL();
  }


  Future<bool> saveOauthToken(String code) {
    return authenticationDataProvider.saveOauthToken(code);
  }

  Future<String> getUserId() {
    return authenticationDataProvider.getUserId();
  }

  Future<void> cleanOauth() {
    return authenticationDataProvider.cleanOauth();
  }

  Future<bool> execRefreshToken(){
    return authenticationDataProvider.execRefreshToken();
  }
}
