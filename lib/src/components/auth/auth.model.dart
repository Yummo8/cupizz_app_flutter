part of '../index.dart';

class AuthModel extends MomentumModel<AuthController> {
  AuthModel(
    AuthController controller, {
    this.otpToken,
    this.email,
    this.nickname,
    this.password,
  }) : super(controller);

  final String otpToken;

  final String email;
  final String nickname;
  final String password;

  @override
  void update({
    String otpToken,
    String registerToken,
    String email,
    String nickname,
    String password,
  }) {
    AuthModel(
      controller,
      otpToken: otpToken ?? this.otpToken,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      password: password ?? this.password,
    ).updateMomentum();
  }
}
