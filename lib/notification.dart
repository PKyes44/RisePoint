import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FlutterLocalNotification {
  FlutterLocalNotification._();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static requestNotificationPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
    //     AndroidFlutterLocalNotificationsPlugin>().requestNotificationsPermission(flutterLocalNotificationsPlugin.getApplication);
  }

  // static Future<void> showNotification() async {
  //   AndroidNotificationDetails androidNotificationDetails =
  //       const AndroidNotificationDetails(
  //     'channel id',
  //     'channel name',
  //     channelDescription: 'channel description',
  //     importance: Importance.max,
  //     priority: Priority.max,
  //     showWhen: false,
  //   );

  //   NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //     iOS: const DarwinNotificationDetails(
  //       badgeNumber: 1,
  //     ),
  //   );

  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'RisePoint',
  //     '게임이 종료되었습니다! 포인트를 확인하십시오',
  //     notificationDetails,
  //   );
  // }
  static Future sendLocalNotification({
    required int idx,
    required String title,
    required String content,
  }) async {
    bool? result;
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (Platform.isAndroid) {
      result = true;
    } else {
      result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    var android = AndroidNotificationDetails(
      'id',
      title,
      channelDescription: content,
      importance: Importance.max,
      priority: Priority.max,
      color: const Color.fromARGB(255, 255, 0, 0),
    );

    var ios = const DarwinNotificationDetails();

    var detail = NotificationDetails(
      android: android,
      iOS: ios,
    );

    if (result == true) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.deleteNotificationChannelGroup('id');

      await flutterLocalNotificationsPlugin.show(
        idx,
        title,
        content,
        detail,
      );
    }
  }
}
