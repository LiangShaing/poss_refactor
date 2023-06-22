import 'package:equatable/equatable.dart';
import 'package:mobile_poss_gp01/enum/bloc_status.dart';

class AuthenticationState extends Equatable {
  final bool refreshTokenExisted;
  final bool accessTokenExisted;
  final String error;
  final BlocStatus status;

  const AuthenticationState(
      {this.refreshTokenExisted = false,
      this.accessTokenExisted = false,
      this.error = '',
      this.status = BlocStatus.initial})
      : super();

  @override
  List<Object?> get props => [refreshTokenExisted, accessTokenExisted, error, status];

  AuthenticationState copyWith(
      {bool? refreshTokenExisted, bool? accessTokenExisted, String? error, BlocStatus? status}) {
    return AuthenticationState(
      refreshTokenExisted: refreshTokenExisted ?? this.refreshTokenExisted,
      accessTokenExisted: accessTokenExisted ?? this.accessTokenExisted,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
