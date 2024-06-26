import 'package:chat_app/src/utils/models/user.dart';
import 'package:chat_app/src/utils/services/cloud_db.dart';
import 'package:chat_app/src/utils/services/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatController extends ChangeNotifier {
  List<KUser> allUsers = [];
  Future<void> getAllUsers() async {
    allUsers = await CloudDB().getAllUsers();
    notifyListeners();
  }

  Future<void> sendMessage(String message, KUser user) async {
    await CloudDB().updateUsersChatList(user, message);
    await CloudDB().sendMessage(message, user);
    NotificationService().sendNotification(
        message,
        "${FirebaseAuth.instance.currentUser!.displayName} send you a message.",
        user.uid
        // "android"
        //
        );
    notifyListeners();
  }

  List<ThreadsModel> threads = [];
  Future<void> getFriends() async {
    threads = await CloudDB().getFriends();
    notifyListeners();
  }
}

final chatProvider = ChangeNotifierProvider<ChatController>((ref) {
  return ChatController();
});
