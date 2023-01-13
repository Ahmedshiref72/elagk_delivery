import 'dart:html';

import 'package:elagk_delivery/shared/utils/app_routes.dart';
import 'package:elagk_delivery/shared/utils/navigation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class Noti{
   static final flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
   static final onNotifications =BehaviorSubject ();
  static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationsSettings = new InitializationSettings(android: androidInitialize,);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings );
  }

  static Future init({bool initScheduled = false})async {
    final android = const AndroidInitializationSettings('mipmap/ic_launcher');
    final ios = DarwinInitializationSettings();
    final initializationSettings =InitializationSettings(android: android,iOS: ios);
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      onDidReceiveNotificationResponse: (payload)async
      {

          onNotifications.add(payload);
          print('object');
      },

    );

}

  static Future showBigTextNotification({var id =0,required String title, required String body,
    var payload, required FlutterLocalNotificationsPlugin fln
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    const AndroidNotificationDetails(
      'you_can_name_it_whatever1',
      'channel_name',
      playSound: true,
      enableLights: true,
      enableVibration: true,
      sound: RawResourceAndroidNotificationSound("pop"),
      importance: Importance.max,
      priority: Priority.high,
    );


    var not= NotificationDetails(android: androidPlatformChannelSpecifics,
    );
    await fln.show(0, title, body,not );
    await init();
  }




}