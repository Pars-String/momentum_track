import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final SharedPreferences storage;
  PreferencesService(this.storage);

  Future<T?> read<T>(String key, {T? defaultValue}) async {
    try {
      final dynamic value = storage.get(key);
      if (value is T) {
        return value;
      }
      return defaultValue;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return defaultValue;
    }
  }

  Future<bool> write<T>(String key, T value) async {
    try {
      if (value is int) {
        return await storage.setInt(key, value);
      } else if (value is double) {
        return await storage.setDouble(key, value);
      } else if (value is bool) {
        return await storage.setBool(key, value);
      } else if (value is String) {
        return await storage.setString(key, value);
      } else if (value is List<String>) {
        return await storage.setStringList(key, value);
      } else {
        throw UnsupportedError('Type $T is not supported');
      }

      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(String key) async {
    try {
      return await storage.remove(key);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return false;
    }
  }
}
