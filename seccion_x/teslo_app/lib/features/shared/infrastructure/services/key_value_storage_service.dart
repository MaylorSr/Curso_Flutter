abstract class KeyValueStorageService {
  //* T es tipo de dato genérico.
  Future<void> setKeyValue<T>(String key, T value);

  Future<T?> getValue<T>(String key);

  Future<bool> removeKey(String key);
}
