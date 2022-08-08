// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveArticleAdapter extends TypeAdapter<SaveArticle> {
  @override
  final int typeId = 0;

  @override
  SaveArticle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveArticle()
      ..articleData = (fields[1] as Map).cast<dynamic, dynamic>();
  }

  @override
  void write(BinaryWriter writer, SaveArticle obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.articleData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveArticleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DarkThemeAdapter extends TypeAdapter<DarkTheme> {
  @override
  final int typeId = 1;

  @override
  DarkTheme read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DarkTheme()..darkTheme = fields[1] as bool;
  }

  @override
  void write(BinaryWriter writer, DarkTheme obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.darkTheme);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DarkThemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SaveNotificationAdapter extends TypeAdapter<SaveNotification> {
  @override
  final int typeId = 2;

  @override
  SaveNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveNotification()
      ..notificationData = (fields[1] as Map).cast<dynamic, dynamic>();
  }

  @override
  void write(BinaryWriter writer, SaveNotification obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.notificationData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SaveNotificationOnOffAdapter extends TypeAdapter<SaveNotificationOnOff> {
  @override
  final int typeId = 3;

  @override
  SaveNotificationOnOff read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveNotificationOnOff()..isNotficationOn = fields[1] as bool;
  }

  @override
  void write(BinaryWriter writer, SaveNotificationOnOff obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.isNotficationOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveNotificationOnOffAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
