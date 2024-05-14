import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kawaiibd_flutterfire_task/src/features/settings/domain/locale/locale.model.dart';
import 'package:kawaiibd_flutterfire_task/src/features/settings/domain/theme/theme.model.dart';

import 'components/internet/view/internet.dart';
import 'components/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import 'constant/constants.dart' show appName;
import 'constant/size.dart';
import 'features/chat.room/presentation/chat.room.view.dart';
import 'features/settings/data/fonts.provider.dart';
import 'features/settings/data/locale.provider.dart';
import 'features/settings/data/performance.overlay.provider.dart';
import 'features/settings/data/theme.provider.dart';
import 'localization/loalization.dart'
    show localizationsDelegates, onGenerateTitle, t;
import 'routing/go.routes.dart';
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
            child: child ?? const ChatRoomView(),
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
