import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationModule {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> scheduleNotification() async {
    Time time = Time(22, 30, 0);
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "1", "channelName", "channel Description",
        icon: "@mipmap/ic_launcher");

    IOSNotificationDetails iosDetails = IOSNotificationDetails();
    NotificationDetails generalNotificationDetails =
    NotificationDetails(android: androidDetails, iOS: iosDetails);

    // await flutterLocalNotificationsPlugin.zonedSchedule(0, "Schedule", "body", TgeneralNotificationDetails);
}
}