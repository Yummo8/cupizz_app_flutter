part of 'index.dart';

const _THEME_KEY = 'cupizz_theme';
const _TOKEN_KEY = 'token';

class StorageService extends MomentumService {
  final _storage = new FlutterSecureStorage();

  Future<void> saveTheme(int index) =>
      _storage.write(key: _THEME_KEY, value: index.toString());

  Future<int> get getTheme async =>
      int.parse(await _storage.read(key: _THEME_KEY) ?? '', onError: (_) => 0);

  Future<void> saveToken(String token) =>
      _storage.write(key: _TOKEN_KEY, value: token);

  Future<void> deleteToken() => _storage.delete(key: _TOKEN_KEY);

  Future<String> get getToken async => await _storage.read(key: _TOKEN_KEY);
}
