part of 'index.dart';

const _THEME_KEY = 'cupizz_theme';
const _TOKEN_KEY = 'token';

class StorageService extends MomentumService {
  StorageService({bool isTesting = false})
      : _storage = isTesting ? _TestingStorage() : FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<void> saveTheme(int index) =>
      _storage.write(key: _THEME_KEY, value: index.toString());

  Future<int> get getTheme async =>
      int.parse(await _storage.read(key: _THEME_KEY) ?? '', onError: (_) => 0);

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
  }

  @override
  Future<void> deleteAll({IOSOptions iOptions, AndroidOptions aOptions}) {
    _data.removeWhere((key, value) => true);
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
  }
}
