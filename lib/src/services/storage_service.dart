import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:momentum/momentum.dart';

const _THEME_KEY = 'cupizz_theme';

class StorageService extends MomentumService {
  final _storage = new FlutterSecureStorage();
  void saveTheme(int index) async {
    await _storage.write(key: _THEME_KEY, value: index.toString());
  }

  Future<int> get getTheme async =>
      int.parse(await _storage.read(key: _THEME_KEY) ?? '', onError: (_) => 0);
}
