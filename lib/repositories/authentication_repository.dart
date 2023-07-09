import 'package:mobile_poss_gp01/data_provider/authentication_data_provider.dart';
import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';

class AuthenticationRepository {
  AuthenticationDataProvider authenticationDataProvider = AuthenticationDataProvider.instance();

  Future<bool> checkRefreshTokenExist() {
    return authenticationDataProvider.checkRefreshTokenExist();
  }

  Future<String> getOauthURL() {
    return authenticationDataProvider.getOauthURL();
  }

  String getLogoutURL() {
    return authenticationDataProvider.getLogoutURL();
  }

  Future<bool> saveOauthToken(String code) {
    return authenticationDataProvider.saveOauthToken(code);
  }

  Future<String> getUserId() {
    return authenticationDataProvider.getUserId();
  }

  Future<Map<String, dynamic>> getTokenInfo() {
    return authenticationDataProvider.getTokenInfo();
  }

  Future<void> cleanOauth() {
    return authenticationDataProvider.cleanOauth();
  }

  Future<bool> execRefreshToken() {
    return authenticationDataProvider.execRefreshToken();
  }

  Future<bool> userVerified(String userId, String password) {
    return authenticationDataProvider.userVerified(userId, password);
  }

  Future<Employee> getEmployee() async {
    Map<String, dynamic> userInfo = await authenticationDataProvider.getTokenInfo();
    List<String> displayName = userInfo['displayName'].toString().split(" ");
    return Employee(displayName.elementAt(1), userInfo['uid'][0], displayName.elementAt(0), []);
  }
}
