import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'src/firebase/init.dart';
import 'package:url_strategy/url_strategy.dart';

import 'src/app.dart' show App;
import 'src/config/get.platform.dart';
import 'src/db/db.dart' show initAppDatum, openDB;
import 'src/db/paths.dart';
import 'src/utils/themes/themes.dart';

const isProduction = false;

void main() async {
  await _init();
  runApp(const ProviderScope(child: App()));
  SystemChrome.setSystemUIOverlayStyle(uiConfig);
}

Future<void> _init() async {
  setPathUrlStrategy();
  pt = PlatformInfo.getCurrentPlatformType();
  await openDB();
  await _initFastCachedImageConfig();
  configLoading();
  await initAppDatum();
  await FirebaseUtils.init();
}

Future<void> _initFastCachedImageConfig() async {
  await FastCachedImageConfig.init(
    subDir: pt.isWeb ? '' : appDir.files.path,
    clearCacheAfter: const Duration(days: 30),
  );
}

void configLoading() => EasyLoading.instance
  ..loadingStyle = EasyLoadingStyle.custom
  ..backgroundColor = Colors.transparent
  ..boxShadow = const <BoxShadow>[]
  ..indicatorColor = kPrimaryColor
  ..progressColor = kPrimaryColor
  ..textColor = Colors.white
  ..textStyle = const TextStyle(
    fontSize: 16.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  )
  ..dismissOnTap = false
  ..userInteractions = false
  ..maskType = EasyLoadingMaskType.custom
  ..maskColor = Colors.black.withOpacity(0.9)
  ..indicatorWidget = const SizedBox(
    height: 70.0,
    width: 70.0,
    child: SpinKitThreeBounce(color: kPrimaryColor, size: 30.0),
  )
  ..indicatorType = EasyLoadingIndicatorType.fadingCircle;
