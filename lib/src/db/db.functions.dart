import 'package:hive/hive.dart';

import '../modules/settings/model/locale/locale.model.dart';
import '../modules/settings/model/settings.model.dart';
import '../modules/settings/model/theme/theme.model.dart';
import 'hive.dart';

class HiveFuntions {
  static void registerHiveAdepters() {
    Hive.registerAdapter(LocaleProfileAdapter());
    Hive.registerAdapter(ThemeProfileAdapter());
    Hive.registerAdapter(AppSettingsAdapter());
  }

  static Future<void> openAllBoxes() async {
    await Hive.openBox<LocaleProfile>(BoxNames.localeProfile);
    await Hive.openBox<ThemeProfile>(BoxNames.themeProfile);
    await Hive.openBox<AppSettings>(BoxNames.appSettings);
  }

  static Future<void> closeAllBoxes() async {
    await Boxes.localeProfile.close();
    await Boxes.themeProfile.close();
    await Boxes.appSettings.close();
  }

  static Future<void> clearAllBoxes() async {
    await Boxes.localeProfile.clear();
    await Boxes.themeProfile.clear();
    await Boxes.appSettings.clear();
  }

  static Future<void> deleteAllBoxes() async {
    await Hive.deleteBoxFromDisk(BoxNames.localeProfile);
    await Hive.deleteBoxFromDisk(BoxNames.themeProfile);
    await Hive.deleteBoxFromDisk(BoxNames.appSettings);
  }
}
