import 'package:chat_app/src/constants/app_strings.dart';
import 'package:chat_app/src/utils/services/auth.dart';
import 'package:chat_app/src/utils/services/cloud_db.dart';
import 'package:chat_app/src/utils/services/notification.dart';
import 'package:chat_app/src/utils/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationController extends ChangeNotifier {
  bool isUserAuthenticated = false;
  bool isLoading = false;
  String myId = "";

  Future<void> signInWithGoogle() async {
    isLoading = true;

    notifyListeners();
    await Authentication.signInWithGoogle();
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      NotificationService.subscribeToFcm(
          FirebaseAuth.instance.currentUser!.uid);
      CloudDB().addUser(FirebaseAuth.instance.currentUser!);
    }

    checkAuth();
    notifyListeners();
  }

  Future<void> getMyId() async {
    String id = LocalStorage().getData(AppStrings.mySecretKey);
    myId = id;
    notifyListeners();
  }

  bool checkAuth() {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      isUserAuthenticated = true;
    } else {
      isUserAuthenticated = false;
    }
    isLoading = false;

    return isUserAuthenticated;
  }

  Future<void> signOut() async {
    NotificationService.unsubscribeFromFcm(
        FirebaseAuth.instance.currentUser!.uid);
    await Authentication.signOut();
    checkAuth();

    notifyListeners();
  }
}

final authProvider = ChangeNotifierProvider<AuthenticationController>((ref) {
  return AuthenticationController();
});

bool isMe(String uid) {
  return uid == FirebaseAuth.instance.currentUser!.uid;
}
