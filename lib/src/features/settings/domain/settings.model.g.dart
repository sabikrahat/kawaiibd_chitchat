// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final int typeId = 4;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings()
      ..firstRun = fields[0] as bool
      ..performanceOverlayEnable = fields[1] as bool
      ..dateFormat = fields[2] as String
      ..timeFormat = fields[3] as String
      ..theme = fields[4] as ThemeProfile
      ..locale = fields[5] as LocaleProfile
      ..firstRunDateTime = fields[6] as DateTime
      ..fontFamily = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.firstRun)
      ..writeByte(1)
      ..write(obj.performanceOverlayEnable)
      ..writeByte(2)
      ..write(obj.dateFormat)
      ..writeByte(3)
      ..write(obj.timeFormat)
      ..writeByte(4)
      ..write(obj.theme)
      ..writeByte(5)
      ..write(obj.locale)
      ..writeByte(6)
      ..write(obj.firstRunDateTime)
      ..writeByte(7)
      ..write(obj.fontFamily);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
