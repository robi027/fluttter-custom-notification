import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseModule {
  FirebaseModule._privateConstructor();

  static final FirebaseModule _instance = FirebaseModule._privateConstructor();

  factory FirebaseModule() {
    return _instance;
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> configure() async {
    print("token ${await _firebaseMessaging.getToken()}");
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launch_background');

    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "1", "channelName", "channel Description",
        icon: "@mipmap/ic_launcher");

    IOSNotificationDetails iosDetails = IOSNotificationDetails();
    NotificationDetails generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          print('notification payload: $payload');
        }
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(notification.hashCode,
            notification.title, notification.body, generalNotificationDetails);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}
