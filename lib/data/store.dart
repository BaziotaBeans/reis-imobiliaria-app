import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<bool> saveMap(String key, Map<String, dynamic> value) async {
    // Converte DateTime para String
    value = value
        .map((k, v) => MapEntry(k, v is DateTime ? v.toIso8601String() : v));
    return saveString(key, jsonEncode(value));
  }

  static Future<String> getString(String key,
      [String defaultValue = '']) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? defaultValue;
  }

  static Future<Map<String, dynamic>> getMap(String key) async {
    try {
      final jsonString = await getString(key);
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      // Converte Strings para DateTime onde necessário
      jsonMap.forEach((k, v) {
        if (k.contains('Date') && v is String) {
          jsonMap[k] = DateTime.parse(v);
        }
      });
      return jsonMap;
    } catch (_) {
      return {};
    }
  }

  static Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
