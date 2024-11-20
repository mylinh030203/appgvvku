import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("ic_vku_nofi");
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // request notification permissions
    _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future showNotification({int id = 0, String? title, String? body, String? payload}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id', // Replace with your channel ID
      'your_channel_name', // Replace with your channel name
      channelDescription: 'Mô tả kênh',
      icon: 'ic_vku_nofi',
      importance: Importance.max,
      priority: Priority.high,
      // playSound: true,

      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    return await _flutterLocalNotificationsPlugin.show(id, title, body, platformChannelSpecifics);
  }

  // close a specific channel notification
  Future cancel(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // close all the notifications available
  Future cancelAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
