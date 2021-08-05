import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationModule {
  LocalNotificationModule._privateConstructor();

  static final LocalNotificationModule instance =
      LocalNotificationModule._privateConstructor();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> showDailyAtTimeNotification(int id, Time time) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "1", "channelName", "channel Description",
        icon: "@mipmap/ic_launcher");
    IOSNotificationDetails iosDetails = IOSNotificationDetails();
    NotificationDetails generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    flutterLocalNotificationsPlugin.showDailyAtTime(
        id, "Schedule", "$id", time, generalNotificationDetails);

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launch_background');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          print('notification payload: $payload');
        }
      },
    );
  }
}
