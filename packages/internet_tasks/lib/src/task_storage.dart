// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:shared_preferences/shared_preferences.dart';

class TaskStroage {
  TaskStroage({
    required SharedPreferences plugin,
  }) : _plugin = plugin;

  final SharedPreferences _plugin;

  String? getValue(String key) => _plugin.getString(key);
  Future<void> setValue(String key, String value) =>
      _plugin.setString(key, value);

  bool contains(String key) => _plugin.containsKey(key);

  Future<bool> remove(String key) => _plugin.remove(key);
}
