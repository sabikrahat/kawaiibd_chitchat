import 'package:hive/hive.dart' show Box, Hive;

import '../modules/settings/model/locale/locale.model.dart';
import '../modules/settings/model/settings.model.dart';
import '../modules/settings/model/theme/theme.model.dart';


class Boxes {
  static Box<LocaleProfile> localeProfile =  Hive.box<LocaleProfile>(BoxNames.localeProfile);
  static Box<ThemeProfile> themeProfile = Hive.box<ThemeProfile>(BoxNames.themeProfile);
  static Box<AppSettings> appSettings = Hive.box<AppSettings>(BoxNames.appSettings);

  static Map<Box<dynamic>, dynamic Function(dynamic json)> get allBoxes => {
        appSettings: (json) => AppSettings.fromJson(json),
      };
}

class BoxNames {
  static const String localeProfile = 'localeProfile';
  static const String themeProfile = 'themeProfile';
  static const String appSettings = 'appSettings';
}

class HiveTypes {
  static const int localeProfile = 0;
  static const int themeProfile = 1;
  static const int appSettings = 2;
}
