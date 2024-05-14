import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/constants.dart';
import '../../../local.db/db.dart';
import '../../../local.db/hive.dart';
import '../../../utils/extensions/extensions.dart';
import '../domain/settings.model.dart';

final _settingsStream = Boxes.appSettings
    .watch(key: appName.toCamelWord)
    .map((event) => event.value as AppSettings);

final settingsStreamProvider = StreamProvider((_) => _settingsStream);

typedef AppSettingsNotifier = NotifierProvider<SettingProvider, AppSettings>;

final settingsProvider = AppSettingsNotifier(SettingProvider.new);

class SettingProvider extends Notifier<AppSettings> {
  @override
  AppSettings build() => ref.watch(settingsStreamProvider).value ?? appSettings;

  // Future<bool> changeInitSetting(AppSettings setting) async {
  //   log.i('First Time Run. Initializing...');
  //   await Boxes.appSettings.put(appName.toCamelWord, setting);
  //   state = setting;
  //   return true;
  // }
}

// class _Data {
//   _Data(this.setting);

//   final AppSettings setting;
// }

// Future<void> _changeInit(_Data data) async {
//   await initHiveDB();
//   await Boxes.appSettings.put(appName, data.setting);
// }
