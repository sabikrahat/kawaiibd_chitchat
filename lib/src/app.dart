import 'package:flutter/material.dart'
    show
        BuildContext,
        Key,
        MaterialApp,
        MediaQuery,
        TextScaler,
        ThemeData,
        Widget;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;
import 'package:kawaiibd_flutterfire_task/src/modules/settings/model/locale/locale.model.dart';
import 'package:kawaiibd_flutterfire_task/src/modules/settings/model/theme/theme.model.dart';

import '../go.routes.dart';
import 'config/constants.dart' show appName;
import 'config/is.under.min.size.dart';
import 'config/screen_enlarge_warning.dart';
import 'config/size.dart';
import 'localization/loalization.dart'
    show localizationsDelegates, onGenerateTitle, t;
import 'modules/home/view/home.dart';
import 'modules/settings/provider/fonts.provider.dart';
import 'modules/settings/provider/locale.provider.dart';
import 'modules/settings/provider/performance.overlay.provider.dart';
import 'modules/settings/provider/theme.provider.dart';
import 'shared/internet/view/internet.dart';
import 'shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import 'utils/extensions/extensions.dart';
import 'utils/logger/logger_helper.dart';

class App extends ConsumerWidget {
  const App({super.key = const Key(appName)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: appName,
      theme: _themeData(ref),
      routerConfig: goRouter,
      onGenerateTitle: onGenerateTitle,
      debugShowCheckedModeBanner: false,
      restorationScopeId: appName.toCamelWord,
      locale: ref.watch(localeProvider).locale,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      showPerformanceOverlay: ref.watch(performanceOverlayProvider),
      builder: EasyLoading.init(builder: (ctx, child) {
        globalCtx = ctx;
        t = AppLocalizations.of(ctx)!;
        topBarSize = ctx.padding.top;
        bottomViewPadding = ctx.padding.bottom;
        log.i('App build. Height: ${ctx.height} px, Width: ${ctx.width} px');
        return MediaQuery(
          data: ctx.mq.copyWith(
            textScaler: const TextScaler.linear(1.0),
            devicePixelRatio: 1.0,
          ),
          child: InternetWidget(
            child: isUnderMinSize(ctx.mq.size)
                ? const ScreenEnlargeWarning()
                : child ?? const HomeView(),
          ),
        );
      }),
    );
  }
}

ThemeData _themeData(WidgetRef ref) {
  final t = ref.watch(themeProvider).theme;
  final f = ref.watch(fontProvider);
  return t.copyWith(
    textTheme: t.textTheme.apply(fontFamily: f),
    primaryTextTheme: t.textTheme.apply(fontFamily: f),
  );
}
