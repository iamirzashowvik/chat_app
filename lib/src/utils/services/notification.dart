import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:chat_app/src/common_widgets/snackbar/ksnackbar.dart';
import 'package:chat_app/src/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static void subscribeToFcm(String userId) async {
    await FirebaseMessaging.instance.subscribeToTopic(userId);
    await FirebaseMessaging.instance
        .subscribeToTopic(Platform.isAndroid ? "android" : "ios");
  }

  static Future<void> unsubscribeFromFcm(String userId) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(userId);
  }

  static showForegroundNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("onMessage: $message");
      RemoteNotification? notification = message.notification;
      final SnackBar snackBar = SnackBar(
          content: Column(
        children: [
          Text(notification?.title ?? ""),
          Text(notification?.body ?? ""),
        ],
      ));
      kSnackbarKey.currentState!.showSnackBar(snackBar);
    });
  }

  Future<void> sendNotification(
      String subject, String title, String topic) async {
    String postUrl =
        'https://fcm.googleapis.com/v1/projects/kawaiibd-chatapp/messages:send';

    final data = {
      "message": {
        "topic": topic,
        "notification": {"title": title, "body": subject},
        "data": {"story_id": "story_12345"}
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer ${AppStrings.notificationSecret}'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
// on success do
      print("true");
    } else {
// on failure do
      log(response.body);
      print("false");
    }
  }
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );
  }
}
