import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class NotificationHelper {
  // Schedule on any day and time
  static void scheduleAlarm(
      {@required DateTime dateTime,
      @required int id,
      @required String title,
      @required String body,
      String payload = ''}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'ic_launcher',
      // sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav', presentAlert: true, presentBadge: true, presentSound: true);
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      id,
      title,
      body,
      dateTime,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  // Get all pending notifications
  static Future<List<PendingNotificationRequest>> get pendingNotifications async =>
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();

  // Schedule notification weekly
  static void scheduleWeeklyNotification({
    @required int id,
    @required String title,
    @required String body,
    @required Day day,
    @required Time time,
    String payload = '',
  }) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'ic_launcher',
      priority: Priority.High,
      // sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav', presentAlert: true, presentBadge: true, presentSound: true);
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      id,
      title,
      body,
      day,
      time,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  // Delete Notification
  static Future<void> deleteNotificatons(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
