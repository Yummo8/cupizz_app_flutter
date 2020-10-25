part of 'index.dart';

class AuthService extends MomentumService {
  Future<void> login(String email, String password) async {
    final graphql = getService<GraphqlService>();
    final result = await graphql
        .mutate(GraphqlQuery.loginMutation(email: email, password: password));

    await getService<StorageService>().saveToken(result.data['login']['token']);
    gotoHome();
  }

  Future<void> logout() async {
    await getService<StorageService>().deleteToken();
    gotoAuth();
  }

  Future<void> gotoHome() async {
    await Router.clearHistoryWithContext(AppConfig.navigatorKey.currentContext);
    await Router.goto(AppConfig.navigatorKey.currentContext, HomeScreen);
  }

  Future<void> gotoAuth() async {
    await Router.clearHistoryWithContext(AppConfig.navigatorKey.currentContext);
    await Router.goto(AppConfig.navigatorKey.currentContext, LoginScreen);
  }
}
