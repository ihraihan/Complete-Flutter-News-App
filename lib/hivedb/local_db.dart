import 'package:hive/hive.dart';

part 'local_db.g.dart';

@HiveType(typeId: 0)
class SaveArticle extends HiveObject {
  @HiveField(1)
  late Map articleData;
}

@HiveType(typeId: 1)
class DarkTheme extends HiveObject {
  @HiveField(1)
  late bool darkTheme;
}

@HiveType(typeId: 2)
class SaveNotification extends HiveObject {
  @HiveField(1)
  late Map notificationData;
}

@HiveType(typeId: 3)
class SaveNotificationOnOff extends HiveObject {
  @HiveField(1)
  late bool isNotficationOn;
}
