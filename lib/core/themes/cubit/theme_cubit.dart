import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:minimart/core/cach_helper/cache_helper.dart';
import 'package:minimart/core/themes/app_theme.dart';
import 'package:minimart/core/themes/cubit/theme_state.dart';

 
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial(AppTheme.themeMode));

  static const String themeBox = "themeBox";
  static const String themeKey = "themeMode";

  /// تحميل الثيم من الكاش عند بداية التطبيق
  Future<void> loadTheme() async {
    await CacheHelper.initBox(themeBox);
    final savedTheme =
        CacheHelper.get<String>(boxName: themeBox, key: themeKey);

    ThemeMode mode;
    if (savedTheme == "light") {
      mode = ThemeMode.light;
    } else if (savedTheme == "dark") {
      mode = ThemeMode.dark;
    } else {
      mode = ThemeMode.system;
    }

    emit(ThemeChanged(mode));
  }

  /// تبديل الثيم وتخزينه
  Future<void> toggleTheme() async {
    ThemeMode newMode;
    if (state.themeMode == ThemeMode.light) {
      newMode = ThemeMode.dark;
      await CacheHelper.save(
          boxName: themeBox, key: themeKey, value: "dark");
    } else {
      newMode = ThemeMode.light;
      await CacheHelper.save(
          boxName: themeBox, key: themeKey, value: "light");
    }

    emit(ThemeChanged(newMode));
  }
}
