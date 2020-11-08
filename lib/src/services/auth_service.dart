part of 'index.dart';

class AuthService extends MomentumService {
  Future<void> login(String email, String password,
      [Future Function() postLogin]) async {
    final graphql = getService<GraphqlService>();
    final result = await graphql
        .mutate(GraphqlQuery.loginMutation(email: email, password: password));

    await getService<StorageService>().saveToken(result.data['login']['token']);
    if (postLogin != null) {
      await postLogin();
    }
    gotoHome();
  }

  Future<void> logout() async {
    await getService<StorageService>().deleteToken();
    // Momentum.restart(AppConfig.navigatorKey.currentContext, momentum());
    Momentum.resetAll(AppConfig.navigatorKey.currentContext);
    gotoAuth();
  }

  Future<void> gotoHome() async {
    await Router.clearHistoryWithContext(AppConfig.navigatorKey.currentContext);
    await Router.goto(AppConfig.navigatorKey.currentContext, MainScreen);
  }

  Future<void> gotoAuth() async {
    await Router.clearHistoryWithContext(AppConfig.navigatorKey.currentContext);
    await Router.goto(AppConfig.navigatorKey.currentContext, LoginScreen);
  }
}
