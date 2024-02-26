abstract class PrefRepository {
  Future<bool> setString(String key, String value);

  Future<String?> getString(String key);

  Future<bool> setInt(String key, int value);

  Future<int?> getInt(String key);

  Future<bool> setBoolean(String key, bool value);

  Future<bool> getBoolean(String key);

  Future<bool> clear(String key);

  Future<bool> delete();
}
