import 'package:hive/hive.dart';
import 'local_db.dart';

class Boxes {
  static Box<SaveArticle> savePosts() {
    return Hive.box<SaveArticle>('saveposts');
  }

  static Box<DarkTheme> saveTheme() {
    return Hive.box<DarkTheme>('themedata');
  }

  static Box<SaveNotification> saveNotification() {
    return Hive.box<SaveNotification>('savenotification');
  }

  static Box<SaveNotificationOnOff> saveNotificationOnOff() {
    return Hive.box<SaveNotificationOnOff>('saveNotificationOnOff');
  }
}
