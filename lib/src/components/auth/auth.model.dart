import 'package:cupizz_app/src/base/base.dart';

class AuthModel extends MomentumModel<AuthController> {
  AuthModel(
    AuthController controller, {
    this.otpToken,
    this.email,
    this.nickname,
    this.password,
    this.isLoading,
  }) : super(controller);

  final String otpToken;

  final String email;
  final String nickname;
  final String password;

  final bool isLoading;

  @override
  void update({
    String otpToken,
    String registerToken,
    String email,
    String nickname,
    String password,
    bool isLoading,
  }) {
    AuthModel(
      controller,
      otpToken: otpToken ?? this.otpToken,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    ).updateMomentum();
  }
}
