part of 'index.dart';

const _THEME_KEY = 'cupizz_theme';
const _TOKEN_KEY = 'token';
const _USER_ID_KEY = 'user_id';

class StorageService extends MomentumService {
  StorageService({bool isTesting = false})
      : _storage = isTesting ? _TestingStorage() : FlutterSecureStorage();

  final FlutterSecureStorage _storage;
}

extension UserIdStorage on StorageService {
  Future<void> saveUserId(String token) async {
    await _storage.write(key: _USER_ID_KEY, value: token);
    getService<GraphqlService>().reset();
  }

  Future<void> deleteUserId() async {
    await _storage.delete(key: _USER_ID_KEY);
    getService<GraphqlService>().reset();
  }

  Future<String> get getUserId async => await _storage.read(key: _USER_ID_KEY);
}

extension TokenStorage on StorageService {
  Future<void> saveToken(String token) async {
    await _storage.write(key: _TOKEN_KEY, value: token);
    getService<GraphqlService>().reset();
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _TOKEN_KEY);
    getService<GraphqlService>().reset();
  }

  Future<String> get getToken async => await _storage.read(key: _TOKEN_KEY);
}

extension ThemeStorage on StorageService {
  Future<void> saveTheme(int index) =>
      _storage.write(key: _THEME_KEY, value: index.toString());

  Future<int> get getTheme async =>
      int.parse(await _storage.read(key: _THEME_KEY) ?? '', onError: (_) => 0);
}

class _TestingStorage implements FlutterSecureStorage {
  final Map<String, String> _data = {};

  @override
  Future<bool> containsKey(
      {String key, IOSOptions iOptions, AndroidOptions aOptions}) async {
    return _data.containsKey(key);
  }

  @override
  Future<void> delete(
      {String key, IOSOptions iOptions, AndroidOptions aOptions}) {
    _data.remove(key);
    return null;
  }

  @override
  Future<void> deleteAll({IOSOptions iOptions, AndroidOptions aOptions}) {
    _data.removeWhere((key, value) => true);
    return null;
  }

  @override
  Future<String> read(
      {String key, IOSOptions iOptions, AndroidOptions aOptions}) async {
    return _data[key];
  }

  @override
  Future<Map<String, String>> readAll(
      {IOSOptions iOptions, AndroidOptions aOptions}) async {
    return _data;
  }

  @override
  Future<void> write(
      {String key,
      String value,
      IOSOptions iOptions,
      AndroidOptions aOptions}) {
    _data.addAll({key: value});
    return null;
  }
}
