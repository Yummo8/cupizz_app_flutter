part of '../index.dart';

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
    await getService<AuthService>().loginEmail(
        email, password, dependOn<CurrentUserController>().getCurrentUser);
    await _afterLogin();
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
      } else if (type == SocialProviderType.facebook) {
        final facebookSignIn = FacebookLogin();
        final facebookLogin = await facebookSignIn.logIn(['email']);
        if (facebookLogin.status == FacebookLoginStatus.loggedIn) {
          debugPrint('Token facebook: ' + facebookLogin.accessToken.token);
          await getService<AuthService>().loginSocial(
              SocialProviderType.facebook,
              facebookLogin.accessToken.token,
              dependOn<CurrentUserController>().getCurrentUser);
        } else if (facebookLogin.status == FacebookLoginStatus.error) {
          await Fluttertoast.showToast(msg: facebookLogin.errorMessage);
          throw facebookLogin.errorMessage;
        } else {
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
    await getService<OneSignalService>().unSubscribe();
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
