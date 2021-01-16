import 'package:cupizz_app/src/base/base.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    }
    return super.bootstrapAsync();
  }

  void navigateToHomeIfAutheticated() async {
    if (await isAuthenticated) {
      await gotoHome();
    }
  }

  Future<bool> get isAuthenticated async =>
      (await getService<StorageService>().getToken) != null;

  Future<void> loginEmail(String email, String password) async {
    await getService<AuthService>().loginEmail(email.trim(), password,
        dependOn<CurrentUserController>().getCurrentUser);
    await _afterLogin();
    unawaited(getService<StorageService>().saveLoginEmail(email.trim()));
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
        await getService<AuthService>().loginSocial(type, tokenGoogle,
            dependOn<CurrentUserController>().getCurrentUser);
        unawaited(googleSignIn.signOut());
      } else if (type == SocialProviderType.facebook) {
        try {
          var accessToken = await FacebookAuth.instance.login();
          print(accessToken.toJson());
          final userData = await FacebookAuth.instance.getUserData();
          print(userData);
          await getService<AuthService>().loginSocial(
              SocialProviderType.facebook,
              accessToken.token,
              dependOn<CurrentUserController>().getCurrentUser);
        } catch (e) {
          switch (e.errorCode) {
            case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
              print('Đang đăng nhập');
              break;
            case FacebookAuthErrorCode.CANCELLED:
              print('login facebook cancelled');
              break;
            case FacebookAuthErrorCode.FAILED:
              await Fluttertoast.showToast(msg: e.toString());
              print('login facebook failed');
              break;
          }
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
    final userId = await getService<StorageService>().getUserId;
    if (userId.isExistAndNotEmpty) {
      await getService<OneSignalService>().subscribe(userId);
      await dependOn<LocationController>()
          .checkPermission(AppConfig.navigatorKey.currentContext);
    }
    reset();
  }

  Future<void> _register(String registerToken) async {
    await trycatch(() async {
      await getService<AuthService>().register(
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
      final otpToken =
          await getService<AuthService>().registerEmail(model.email);
      model.update(otpToken: otpToken);
    }, throwError: true);
  }

  Future<void> vertifyOtp(String otp) async {
    if (!model.otpToken.isExistAndNotEmpty) return;
    await trycatch(() async {
      final registerToken =
          await getService<AuthService>().verifyOtpEmail(model.otpToken, otp);
      await _register(registerToken);
    });
  }

  Future<void> logout() async {
    await getService<AuthService>().logout();
    unawaited(getService<OneSignalService>().unSubscribe());
    await Router.resetWithContext<LoginScreen>(
        AppConfig.navigatorKey.currentContext);
    Momentum.resetAll(AppConfig.navigatorKey.currentContext);
    Momentum.restart(AppConfig.navigatorKey.currentContext, momentum());
  }

  Future<void> gotoHome() async {
    final router = getService<Router>();
    await router.clearHistory();
    await Router.goto(AppConfig.navigatorKey.currentContext, MainScreen);
  }

  Future<void> gotoAuth() async {
    final router = getService<Router>();
    await router.clearHistory();
    await Router.goto(AppConfig.navigatorKey.currentContext, LoginScreen);
  }
}
