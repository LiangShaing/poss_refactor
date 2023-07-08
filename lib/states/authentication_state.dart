import 'package:equatable/equatable.dart';
import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';
import 'package:mobile_poss_gp01/enum/bloc_status.dart';

class AuthenticationState extends Equatable {
  final bool inLoginScreen;
  final bool refreshTokenExisted;
  final bool accessTokenExisted;
  final bool ldapVerified;
  final String ldapPassword;
  final Employee? employee;
  final String error;
  final BlocStatus status;

  const AuthenticationState(
      {this.inLoginScreen = true,
      this.refreshTokenExisted = false,
      this.accessTokenExisted = false,
      this.ldapVerified = false,
      this.ldapPassword = '',
      this.employee,
      this.error = '',
      this.status = BlocStatus.initial})
      : super();

  @override
  List<Object?> get props =>
      [inLoginScreen, refreshTokenExisted, accessTokenExisted, ldapVerified, ldapPassword, employee, error, status];

  AuthenticationState copyWith(
      {bool? inLoginScreen,
      bool? refreshTokenExisted,
      bool? accessTokenExisted,
      bool? ldapVerified,
      Employee? employee,
      String? ldapPassword,
      String? error,
      BlocStatus? status}) {
    return AuthenticationState(
      inLoginScreen: inLoginScreen ?? this.inLoginScreen,
      refreshTokenExisted: refreshTokenExisted ?? this.refreshTokenExisted,
      accessTokenExisted: accessTokenExisted ?? this.accessTokenExisted,
      ldapVerified: ldapVerified ?? this.ldapVerified,
      ldapPassword: ldapPassword ?? this.ldapPassword,
      employee: employee ?? this.employee,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}

class AuthenticationLogoutSuccess extends AuthenticationState {}
