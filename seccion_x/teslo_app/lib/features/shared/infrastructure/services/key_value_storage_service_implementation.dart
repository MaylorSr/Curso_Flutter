import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_storage_service.dart';

const keyToken = 'token';


class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future getSharedPreferenceService() async {
    return SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPreferenceService();

    switch (T) {
      case int:
        return prefs.getInt(key);

      case String:
        return prefs.getString(key);

      case bool:
        return prefs.getBool(key);

      case double:
        return prefs.getDouble(key);
      case List<String>:
        return prefs.getStringList(key);

      default:
        throw UnimplementedError(
            'This set was not implement type ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPreferenceService();

    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPreferenceService();

    switch (T) {
      case int:
        prefs.setInt(key, value);
        break;
      case String:
        prefs.setString(key, value);
        break;
      case bool:
        prefs.setBool(key, value);

        break;
      case double:
        prefs.setDouble(key, value);
        break;
      case List<String>:
        prefs.setStringList(key, value);
        break;
      default:
        throw UnimplementedError(
            'This set was not implement type ${T.runtimeType}');
    }
  }
}
