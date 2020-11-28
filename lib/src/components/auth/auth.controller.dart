part of '../index.dart';

class AuthController extends MomentumController<AuthModel> {
  @override
  AuthModel init() {
    return AuthModel(this);
  }

  @override
  Future<void> bootstrapAsync() async {
    if (!await isAuthenticated) {
      await gotoAuth();
    }
  }

  Future<bool> get isAuthenticated async =>
      (await getService<StorageService>().getToken) != null;

  Future<void> login(String email, String password) async {
    await getService<AuthService>().login(
        email, password, dependOn<CurrentUserController>().getCurrentUser);

    await gotoHome();
    final userId = await getService<StorageService>().getUserId;
    if (userId.isExistAndNotEmpty) {
      await getService<OneSignalService>().subscribe(userId);
    }
  }

  Future<void> logout() async {
    await getService<AuthService>().logout();
    await getService<OneSignalService>().unSubscribe();
    await gotoAuth();
  }

  Future<void> gotoHome() async {
    final router = getService<RouterService>();
    await router.clearHistory();
    await RouterService.goto(AppConfig.navigatorKey.currentContext, MainScreen);
  }

  Future<void> gotoAuth() async {
    final router = getService<RouterService>();
    await router.clearHistory();
    await RouterService.goto(
        AppConfig.navigatorKey.currentContext, LoginScreen);
  }
}
