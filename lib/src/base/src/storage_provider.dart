part of base;

class StorageProvider {
  Future<void> save(String key, String data) async {
    final _storage = await SharedPreferences.getInstance();
    await _storage.setString(key, data);
  }

  Future<String?> read(String key) async {
    final _storage = await SharedPreferences.getInstance();
    return _storage.getString(key);
  }

  Future<void> delete(String key) async {
    final _storage = await SharedPreferences.getInstance();
    await _storage.remove(key);
  }
}
