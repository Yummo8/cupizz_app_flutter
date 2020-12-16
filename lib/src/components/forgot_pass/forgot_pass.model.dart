part of '../index.dart';

class ForgotPassModel extends MomentumModel<ForgotController> {
  ForgotPassModel(
    ForgotController controller, {
    this.token,
    this.isSendingOtp,
    this.isChangingPass,
    this.data,
    this.email,
    this.isVerifingOtp,
  }) : super(controller);

  final String token;
  final ForgotPassOutput data;
  final String email;

  final bool isSendingOtp;
  final bool isChangingPass;
  final bool isVerifingOtp;

  @override
  void update({
    String token,
    bool isSendingOtp,
    bool isChangingPass,
    bool isVerifingOtp,
    ForgotPassOutput data,
    String email,
  }) {
    ForgotPassModel(
      controller,
      token: token ?? this.token,
      isSendingOtp: isSendingOtp ?? this.isSendingOtp,
      isChangingPass: isChangingPass ?? this.isChangingPass,
      isVerifingOtp: isVerifingOtp ?? this.isVerifingOtp,
      data: data ?? this.data,
      email: email ?? this.email,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return ForgotPassModel(controller);
  }

  @override
  Map<String, dynamic> toJson() => {};
}
