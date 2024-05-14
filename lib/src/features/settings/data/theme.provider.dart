import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/constants.dart';
import '../../../local.db/hive.dart';
import '../../../utils/extensions/extensions.dart';
import '../domain/settings.model.dart';
import '../domain/theme/theme.model.dart';
import 'settings.provider.dart';

typedef ThemeNotifier = NotifierProvider<ThemeProvider, ThemeProfile>;

final themeProvider = ThemeNotifier(ThemeProvider.new);

class ThemeProvider extends Notifier<ThemeProfile> {
  @override
  ThemeProfile build() => ref.watch(settingsProvider.select((v) => v.theme));

  ThemeProfile get theme => state;

  Future<void> changeTheme() async {
    // await compute(_changeTheme, _Data(ref.read(settingsProvider), theme));
    await Boxes.appSettings.put(
        appName.toCamelWord,
        (Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings())
            .copyWith(theme: theme.toggled));
  }
}

// void _changeTheme(_Data data) {
//   openDBSync(data.dir);
//   data.setting.theme = data.theme;
//   db.writeTxnSync(() => db.appSettings.putSync(data.setting));
// }

// class _Data {
//   _Data(this.setting, this.theme);

//   final AppDir dir = appDir;
//   final ThemeProfile theme;
//   final AppSettings setting;
// }
