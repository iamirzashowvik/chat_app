import 'package:chat_app/src/utils/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationController extends ChangeNotifier {
  bool isUserAuthenticated = false;
  bool isLoading = false;

  Future<void> signInWithGoogle() async {
    isLoading = true;
    notifyListeners();
    await Authentication.signInWithGoogle();
    checkAuth();
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
    await Authentication.signOut();
    checkAuth();
    notifyListeners();
  }
}

final authProvider = ChangeNotifierProvider<AuthenticationController>((ref) {
  return AuthenticationController();
});
