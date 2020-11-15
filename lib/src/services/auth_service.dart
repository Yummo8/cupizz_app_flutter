part of 'index.dart';

class AuthService extends MomentumService {
  Future<void> login(String email, String password,
      [Future Function() postLogin]) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.loginMutation(email: email, password: password);

    await getService<StorageService>().saveToken(data['token']);
    if (postLogin != null) {
      await postLogin();
    }
    gotoHome();
  }

  Future<void> logout() async {
    await getService<StorageService>().deleteToken();
    Momentum.resetAll(context);
    gotoAuth();
  }

  Future<void> gotoHome() async {
    await Router.clearHistoryWithContext(context);
    await Router.goto(context, MainScreen);
  }

  Future<void> gotoAuth() async {
    await Router.clearHistoryWithContext(context);
    await Router.goto(context, LoginScreen);
  }
}
