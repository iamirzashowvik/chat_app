import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static void subscribeToFcm(String userId) async {
    await FirebaseMessaging.instance.subscribeToTopic(userId);
    await FirebaseMessaging.instance
        .subscribeToTopic(Platform.isAndroid ? "android" : "ios");
  }
}
