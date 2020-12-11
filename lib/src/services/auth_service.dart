part of 'index.dart';

class AuthService extends MomentumService {
  Future<void> loginEmail(String email, String password,
      [Future Function() postLogin]) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.loginMutation(email: email, password: password);
    await Future.wait([
      getService<StorageService>().saveToken(data['token']),
      getService<StorageService>().saveUserId(data['info']['id']),
    ]);
    if (postLogin != null) {
      await postLogin();
    }
  }

  Future<void> loginSocial(SocialProviderType type, String accessToken,
      [Future Function() postLogin]) async {
    final graphql = getService<GraphqlService>();
    final data =
        await graphql.loginSocialMutation(type: type, accessToken: accessToken);
    await Future.wait([
      getService<StorageService>().saveToken(data['token']),
      getService<StorageService>().saveUserId(data['info']['id']),
    ]);
    if (postLogin != null) {
      await postLogin();
    }
  }

  Future<void> logout() async {
    await getService<StorageService>().deleteToken();
    await getService<StorageService>().deleteUserId();
  }
}
