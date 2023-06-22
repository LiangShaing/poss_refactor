import 'package:equatable/equatable.dart';
import 'package:mobile_poss_gp01/enum/bloc_status.dart';

class AuthenticationState extends Equatable {
  final String refreshToken;
  final String accessToken;
  final String error;
  final BlocStatus status;

  const AuthenticationState(
      {this.refreshToken = '', this.accessToken = '', this.error = '', this.status = BlocStatus.initial})
      : super();

  @override
  List<Object?> get props => [refreshToken, accessToken, error, status];

  AuthenticationState copyWith({String? refreshToken, String? accessToken, String? error, BlocStatus? status}) {
    return AuthenticationState(
      refreshToken: refreshToken ?? this.refreshToken,
      accessToken: accessToken ?? this.accessToken,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
