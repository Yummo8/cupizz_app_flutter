part of base;

class CacheProvider {
  static final CacheProvider _instance = CacheProvider._internal();

  CacheProvider._internal();

  factory CacheProvider() => _instance;

  Future<void> cache(String url, String data) async {
    final _storage = await SharedPreferences.getInstance();
    await _storage.setString(url, data);
  }

  Future<String> readCache(String url) async {
    final _storage = await SharedPreferences.getInstance();
    return _storage.getString(url);
  }
}
