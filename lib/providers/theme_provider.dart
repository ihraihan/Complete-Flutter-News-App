import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../hivedb/boxes.dart';
import '../hivedb/local_db.dart';

class ThemeProvider extends ChangeNotifier {
  late bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeProvider() {
    _darkTheme = false;
    loadThemeData();
  }
  toggleTheme() {
    _darkTheme = !_darkTheme;
    saveThemeData();
    notifyListeners();
  }

  saveThemeData() {
    final box = Hive.box<DarkTheme>('themedata');
    final theme = DarkTheme()..darkTheme = _darkTheme;
    box.put("darkTheme", theme);
  }

  loadThemeData() {
    final data = Boxes.saveTheme().get("darkTheme");
    if (data != null) {
      _darkTheme = data.darkTheme;
    }
  }
}
