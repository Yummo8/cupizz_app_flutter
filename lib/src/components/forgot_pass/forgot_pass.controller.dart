import 'package:cupizz_app/src/base/base.dart';

class ForgotController extends MomentumController<ForgotPassModel> {
  @override
  ForgotPassModel init() {
    return ForgotPassModel(
      this,
    );
  }

  Future sendOtp(String email) async {
    try {
      final service = Get.find<UserService>();
      model.update(email: email, isSendingOtp: true);
      final token = await service.forgotPassword(email);
      model.update(token: token);
    } catch (e) {
      await Fluttertoast.showToast(msg: e.toString());
      rethrow;
    } finally {
      model.update(isSendingOtp: false);
    }
  }

  Future verifyOtp(String otp) async {
    try {
      final service = Get.find<UserService>();
      model.update(isVerifingOtp: true);
      final data = await service.validateForgotPasswordToken(model.token, otp);
      model.update(data: data);
    } catch (e) {
      await Fluttertoast.showToast(msg: e.toString());
      rethrow;
    } finally {
      model.update(isVerifingOtp: false);
    }
  }

  Future changePass(String newPass) async {
    try {
      final service = Get.find<UserService>();
      model.update(isChangingPass: true);
      await service.changePasswordByForgotPasswordToken(
          model.data?.token, newPass);
      reset();
      await Fluttertoast.showToast(
          msg:
              'Cài lại mật khẩu thành công.\nBạn hãy đăng nhập lại bằng mật khẩu mới.');
    } catch (e) {
      await Fluttertoast.showToast(msg: e.toString());
      rethrow;
    } finally {
      model.update(isChangingPass: false);
    }
  }
}
