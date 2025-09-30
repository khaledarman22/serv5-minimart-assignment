import 'package:flutter/material.dart';
import 'package:minimart/core/cach_helper/cache_boxs.dart';
import 'package:minimart/core/cach_helper/cache_helper.dart';
import 'package:minimart/core/cach_helper/cache_keys.dart';
import 'package:minimart/core/themes/dark_theme.dart';
import 'package:minimart/core/themes/light_theme.dart';

class AppTheme {
  static ThemeData get light => LightTheme.theme;
  static ThemeData get dark => DarkTheme.theme;
  static ThemeMode themeMode = ThemeMode.system;
}
