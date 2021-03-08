import 'package:cupizz_app/src/base/base.dart';
import 'package:hive/hive.dart';

const _THEME_KEY = 'cupizz_theme';
const _TOKEN_KEY = 'token';
const _USER_ID_KEY = 'user_id';
const _EMAIL_KEY = 'email';

class StorageService extends GetxService {
  final bool isTesting;
  final Map<String, dynamic> _data = {};
  late final Box _box;

  StorageService({this.isTesting = false});

  Future<StorageService> init() async {
    _box = await Hive.openBox('StorageService');
    return this;
  }

  Future set<T>(String key, T value) async {
    if (isTesting) {
      _data.addAll({key: value});
    } else {
      await _box.put(key, value);
    }
  }

  Future<T?> get<T>(String key) async {
    if (isTesting) {
      return _data[key];
    } else {
      return await _box.get(key);
    }
  }

  Future delete(String key) async {
    if (isTesting) {
      _data.remove(key);
    } else {
      await _box.delete(key);
    }
  }
}

extension LoginEmailStorage on StorageService {
  Future<void> saveLoginEmail(String email) => set(_EMAIL_KEY, email);
  Future<void> deleteLoginEmail() => delete(_EMAIL_KEY);
  Future<String?> get getLoginEmail async => get<String>(_EMAIL_KEY);
}

extension UserIdStorage on StorageService {
  Future<void> saveUserId(String token) async {
    await set(_USER_ID_KEY, token);
    await Get.find<GraphqlService>().reset();
  }

  Future<void> deleteUserId() async {
    await delete(_USER_ID_KEY);
    await Get.find<GraphqlService>().reset();
  }

  Future<String?> get getUserId async => get(_USER_ID_KEY);
}

extension TokenStorage on StorageService {
  Future<void> saveToken(String token) async {
    await set(_TOKEN_KEY, token);
    await Get.find<GraphqlService>().reset();
  }

  Future<void> deleteToken() async {
    await delete(_TOKEN_KEY);
    await Get.find<GraphqlService>().reset();
  }

  Future<String?> get getToken async => get(_TOKEN_KEY);
}

extension ThemeStorage on StorageService {
  Future<void> saveTheme(int index) async => set(_THEME_KEY, index.toString());
  Future<int> get getTheme async => await get<int>(_THEME_KEY) ?? 0;
}
