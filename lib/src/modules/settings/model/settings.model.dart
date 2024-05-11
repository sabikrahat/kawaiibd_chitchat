import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../config/constants.dart';
import '../../../db/hive.dart';
import '../../../utils/extensions/extensions.dart';
import '../provider/date.format.provider.dart';
import '../provider/time.format.provider.dart';
import 'locale/locale.model.dart';
import 'theme/theme.model.dart';

part 'settings.model.crud.ext.dart';
part 'settings.model.ext.dart';
part 'settings.model.g.dart';

@HiveType(typeId: HiveTypes.appSettings)
class AppSettings extends HiveObject {
  AppSettings();

  @HiveField(0)
  bool firstRun = true;
  @HiveField(1)
  bool performanceOverlayEnable = false;
  @HiveField(2)
  String dateFormat = dateFormates.first;
  @HiveField(3)
  String timeFormat = timeFormates.first;
  @HiveField(4)
  ThemeProfile theme = ThemeProfile.light;
  @HiveField(5)
  LocaleProfile locale = LocaleProfile.english;
  @HiveField(6)
  DateTime firstRunDateTime = DateTime.now().toUtc();
  @HiveField(7)
  String fontFamily = GoogleFonts.nunito().fontFamily!;
  

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'firstRunDateTime': firstRunDateTime.toIso8601String(),
        'performanceOverlayEnable': performanceOverlayEnable,
        'dateFormat': dateFormat,
        'timeFormat': timeFormat,
        'fontFamily': fontFamily,
        'locale': locale.name,
        'firstRun': firstRun,
        'theme': theme.name,
      };

  factory AppSettings.fromJson(String source) =>
      AppSettings.fromRawJson(json.decode(source));

  factory AppSettings.fromRawJson(Map<String, dynamic> json) => AppSettings()
    ..firstRunDateTime = DateTime.parse(json['firstRunDateTime'] as String)
    ..performanceOverlayEnable = json['performanceOverlayEnable'] as bool
    ..locale = LocaleProfile.values.firstWhere(
        (e) => e.name == json['locale'] as String,
        orElse: () => LocaleProfile.english)
    ..theme = ThemeProfile.values.firstWhere(
        (e) => e.name == json['theme'] as String,
        orElse: () => ThemeProfile.light)
    ..dateFormat = json['dateFormat'] as String
    ..timeFormat = json['timeFormat'] as String
    ..fontFamily = json['fontFamily'] as String
    ..firstRun = json['firstRun'] as bool;

  @override
  String toString() => toRawJson();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppSettings && other.firstRunDateTime == firstRunDateTime;
  }

  @override
  int get hashCode => firstRunDateTime.hashCode;
}
