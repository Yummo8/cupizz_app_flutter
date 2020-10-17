part of base;

class StorageProvider {
  final _storage = Storage.FlutterSecureStorage();

  Future<void> save(String key, String data) =>
      _storage.write(key: key, value: data);

  Future<String> read(String key) => _storage.read(key: key);

  Future<void> delete(String key) => _storage.delete(key: key);
}
