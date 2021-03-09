import 'package:cupizz_app/src/base/base.dart';

class AuthService extends GetxService {
  Future<void> loginEmail(String email, String password,
      [Future Function()? postLogin]) async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.loginMutation(email: email, password: password);
    await Future.wait([
      Get.find<StorageService>().saveToken(data['token']),
      Get.find<StorageService>().saveUserId(data['info']['id']),
    ]);
    if (postLogin != null) {
      await postLogin();
    }
  }

  Future<void> loginSocial(SocialProviderType type, String? accessToken,
      [Future Function()? postLogin]) async {
    final graphql = Get.find<GraphqlService>();
    final data =
        await graphql.loginSocialMutation(type: type, accessToken: accessToken);
    await Future.wait([
      Get.find<StorageService>().saveToken(data['token']),
      Get.find<StorageService>().saveUserId(data['info']['id']),
    ]);
    if (postLogin != null) {
      await postLogin();
    }
  }

  Future<void> register(String? token, String? nickname, String? password,
      [Future Function()? postRegister]) async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.registerMutation(
      nickname: nickname,
      password: password,
      token: token,
    );
    await Future.wait([
      Get.find<StorageService>().saveToken(data['token']),
      Get.find<StorageService>().saveUserId(data['info']['id']),
    ]);
    if (postRegister != null) {
      await postRegister();
    }
  }

  Future<String?> registerEmail(String? email) async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.registerEmailMutation(email);
    return data;
  }

  Future<String?> verifyOtpEmail(String? token, String otp) async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.verifyOtpMutation(token, otp);
    return data;
  }

  Future<void> logout() async {
    await Get.find<StorageService>().deleteToken();
    await Get.find<StorageService>().deleteUserId();
  }
}
