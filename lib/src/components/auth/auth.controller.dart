import 'package:cupizz_app/src/base/base.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../app.dart';

class AuthController extends MomentumController<AuthModel> {
  @override
  AuthModel init() {
    return AuthModel(this);
  }

  @override
  Future<void> bootstrapAsync() async {
    if (await isAuthenticated) {
      await dependOn<LocationController>()
          .checkPermission(AppConfig.navigatorKey.currentContext);
      unawaited(gotoHome());
    } else {
      unawaited(gotoAuth());
    }
    return super.bootstrapAsync();
  }

  void navigateToHomeIfAutheticated() async {
    if (await isAuthenticated) {
      await gotoHome();
    }
  }

  Future<bool> get isAuthenticated async =>
      (await Get.find<StorageService>().getToken) != null;

  Future<void> loginEmail(String email, String password) async {
    await Get.find<AuthService>().loginEmail(email.trim(), password,
        dependOn<CurrentUserController>().getCurrentUser);
    await _afterLogin();
    unawaited(Get.find<StorageService>().saveLoginEmail(email.trim()));
  }

  Future<void> loginSocial(SocialProviderType type) async {
    try {
      model.update(isLoading: true);
      if (type == SocialProviderType.google) {
        final googleSignIn = GoogleSignIn(
          scopes: <String>[
            'email',
            'profile',
            'https://www.googleapis.com/auth/contacts.readonly'
          ],
        );
        await googleSignIn.signIn();
        if (googleSignIn.currentUser == null) return;
        GoogleSignInAuthentication auth;
        auth = await googleSignIn.currentUser.authentication;
        final tokenGoogle = auth.accessToken;
        debugPrint('Token Google: $tokenGoogle');
        await Get.find<AuthService>().loginSocial(type, tokenGoogle,
            dependOn<CurrentUserController>().getCurrentUser);
        unawaited(googleSignIn.signOut());
      } else if (type == SocialProviderType.facebook) {
        try {
          var accessToken = await FacebookAuth.instance.login();
          if (accessToken == null || !accessToken.token.isExistAndNotEmpty) {
            return;
          }
          await Get.find<AuthService>().loginSocial(
              SocialProviderType.facebook,
              accessToken.token,
              dependOn<CurrentUserController>().getCurrentUser);
        } catch (e) {
          if (e.errorCode != null) {
            switch (e.errorCode) {
              case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
                print('Đang đăng nhập');
                break;
              case FacebookAuthErrorCode.CANCELLED:
                print('login facebook cancelled');
                break;
              case FacebookAuthErrorCode.FAILED:
                print('login facebook failed');
                await Fluttertoast.showToast(msg: e.toString());
                break;
            }
          } else {
            await Fluttertoast.showToast(msg: e.toString());
          }
          return;
        }
      } else {
        return;
      }
      await _afterLogin();
    } catch (e) {
      await Fluttertoast.showToast(msg: '$e');
      rethrow;
    } finally {
      model.update(isLoading: false);
    }
  }

  Future _afterLogin() async {
    await gotoHome();
    final userId = await Get.find<StorageService>().getUserId;
    if (userId.isExistAndNotEmpty) {
      await Get.find<OneSignalService>().subscribe(userId);
      await dependOn<LocationController>()
          .checkPermission(AppConfig.navigatorKey.currentContext);
    }
    reset();
  }

  Future<void> _register(String registerToken) async {
    await trycatch(() async {
      await Get.find<AuthService>().register(
        registerToken,
        model.nickname,
        model.password,
        dependOn<CurrentUserController>().getCurrentUser,
      );
      await _afterLogin();
    });
  }

  Future<void> registerEmail() async {
    await trycatch(() async {
      final otpToken = await Get.find<AuthService>().registerEmail(model.email);
      model.update(otpToken: otpToken);
    }, throwError: true);
  }

  Future<void> vertifyOtp(String otp) async {
    if (!model.otpToken.isExistAndNotEmpty) return;
    await trycatch(() async {
      final registerToken =
          await Get.find<AuthService>().verifyOtpEmail(model.otpToken, otp);
      await _register(registerToken);
    });
  }

  Future<void> logout() async {
    await Get.find<AuthService>().logout();
    unawaited(Get.find<OneSignalService>().unSubscribe());
    Get.reset();
    await initServices();
    Momentum.resetAll(AppConfig.navigatorKey.currentContext);
    Momentum.restart(AppConfig.navigatorKey.currentContext, momentum());
    unawaited(Get.offAndToNamed(Routes.login));
  }

  Future<void> gotoHome() async {
    await Get.offAllNamed(Routes.home);
  }

  Future<void> gotoAuth() async {
    await Get.offAllNamed(Routes.login);
  }
}
