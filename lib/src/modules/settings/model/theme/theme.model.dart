import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../../../../db/hive.dart';
import '../../../../utils/themes/dark/dark.theme.dart';
import '../../../../utils/themes/light/light.theme.dart';

part 'theme.model.ext.dart';
part 'theme.model.g.dart';

@HiveType(typeId: HiveTypes.themeProfile)
enum ThemeProfile {
  @HiveField(0)
  dark,
  @HiveField(1)
  light,
}

extension ThemeProfileExt on ThemeProfile {
  ThemeData get themeData {
    switch (this) {
      case ThemeProfile.dark:
        return darkTheme;
      case ThemeProfile.light:
        return lightTheme;
    }
  }

  String get name {
    switch (this) {
      case ThemeProfile.dark:
        return 'dark';
      case ThemeProfile.light:
        return 'light';
    }
  }

  static ThemeProfile getTheme(String name) {
    switch (name) {
      case 'dark':
        return ThemeProfile.dark;
      case 'light':
        return ThemeProfile.light;
      default:
        return ThemeProfile.light;
    }
  }

  bool get isDark => this == ThemeProfile.dark;

  bool get isLight => this == ThemeProfile.light;
}
