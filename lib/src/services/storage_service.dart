import 'package:cupizz_app/src/base/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _THEME_KEY = 'cupizz_theme';
const _TOKEN_KEY = 'token';
const _USER_ID_KEY = 'user_id';
const _EMAIL_KEY = 'email';

class StorageService extends MomentumService {
  final bool isTesting;
  StorageService({this.isTesting = false});

  Future<SharedPreferences> get storage =>
      isTesting ? _TestingStorage() : SharedPreferences.getInstance();
}

extension LoginEmailStorage on StorageService {
  Future<void> saveLoginEmail(String email) async {
    await (await storage).setString(_EMAIL_KEY, email);
  }

  Future<void> deleteLoginEmail() async {
    await (await storage).remove(_EMAIL_KEY);
  }

  Future<String> get getLoginEmail async =>
      await (await storage).getString(_EMAIL_KEY);
}

extension UserIdStorage on StorageService {
  Future<void> saveUserId(String token) async {
    await (await storage).setString(_USER_ID_KEY, token);
    getService<GraphqlService>().reset();
  }

  Future<void> deleteUserId() async {
    await (await storage).remove(_USER_ID_KEY);
    getService<GraphqlService>().reset();
  }

  Future<String> get getUserId async =>
      await (await storage).getString(_USER_ID_KEY);
}

extension TokenStorage on StorageService {
  Future<void> saveToken(String token) async {
    await (await storage).setString(_TOKEN_KEY, token);
    getService<GraphqlService>().reset();
  }

  Future<void> deleteToken() async {
    await (await storage).remove(_TOKEN_KEY);
    getService<GraphqlService>().reset();
  }

  Future<String> get getToken async =>
      await (await storage).getString(_TOKEN_KEY);
}

extension ThemeStorage on StorageService {
  Future<void> saveTheme(int index) async =>
      await (await storage).setString(_THEME_KEY, index.toString());

  Future<int> get getTheme async =>
      int.tryParse(await (await storage).getString(_THEME_KEY) ?? '') ?? 0;
}

class _TestingStorage implements SharedPreferences {
  final Map<String, dynamic> _data = {};

  @override
  Future<bool> clear() async {
    _data.removeWhere((key, value) => true);
    return true;
  }

  @override
  Future<bool> commit() async {
    return true;
  }

  @override
  dynamic get(String key) {
    return _data[key];
  }

  @override
  bool getBool(String key) {
    return _data[key] as bool;
  }

  @override
  double getDouble(String key) {
    return double.tryParse(_data[key]);
  }

  @override
  int getInt(String key) {
    return int.tryParse(_data[key]);
  }

  @override
  Set<String> getKeys() {
    return _data.keys.toSet();
  }

  @override
  String getString(String key) {
    return _data[key].toString();
  }

  @override
  List<String> getStringList(String key) {
    return (_data[key] as List ?? []).map((e) => e.toString()).toList();
  }

  @override
  Future<void> reload() async {
    return;
  }

  @override
  Future<bool> remove(String key) async {
    _data.remove(key);
    return true;
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    _data.addAll({key: value});
    return true;
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    _data.addAll({key: value});
    return true;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    _data.addAll({key: value});
    return true;
  }

  @override
  Future<bool> setString(String key, String value) async {
    _data.addAll({key: value});
    return true;
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    _data.addAll({key: value});
    return true;
  }

  @override
  bool containsKey(String key) {
    return _data.containsKey(key);
  }
}
