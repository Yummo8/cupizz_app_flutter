part of base;

class CacheProvider {
  static final CacheProvider _instance = CacheProvider._internal();

  CacheProvider._internal();

  factory CacheProvider() => _instance;

  final _storage = storage.FlutterSecureStorage();

  Future<void> cache(String url, String data) async {
    await _storage.write(key: url, value: data);
  }

  Future<String> readCache(String url) async {
    return _storage.read(key: url);
  }
}
