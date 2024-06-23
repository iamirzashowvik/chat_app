import 'dart:convert';
import 'package:chat_app/src/constants/app_strings.dart';
import 'package:chat_app/src/utils/models/user.dart';
import 'package:chat_app/src/utils/services/local_storage.dart';
import 'package:chat_app/src/utils/services/user_secret_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudDB {
  final db = FirebaseFirestore.instance;

  Future<int> getLastKey() async {
    var data = await db.collection("lastKey").doc("lastKey").get();
    if (!data.exists) {
      return 0;
    }
    return int.tryParse(data.data()!["lastKey"].toString()) ?? 0;
  }

  Future<void> setLastKey(int key) async {
    await db
        .collection("lastKey")
        .doc("lastKey")
        .set({"lastKey": key.toString()});
  }

  void addUser(User user) async {
    int n = await getLastKey();
    int userKey = UserSecretGenerator().nextPrime(n);
    var dbUser = await db
        .collection("users")
        .where("email", isEqualTo: user.email)
        .get();

    if (dbUser.docs.isNotEmpty) {
      var data = dbUser.docs.first.data()['key'];

      await LocalStorage().saveData(AppStrings.mySecretKey, data);
    } else {
      var data = {
        "username": user.displayName,
        "email": user.email,
        "uid": user.uid,
        "photoURL": user.photoURL,
        "key": userKey.toString()
      };

      await db
          .collection("users")
          .doc(user.uid)
          .set(data, SetOptions(merge: true));

      await LocalStorage().saveData(AppStrings.mySecretKey, userKey.toString());
      await setLastKey(userKey);
    }
  }

  Future<KUser?> getUser(String uid) async {
    var data = await db.collection("users").doc(uid).get();

    if (!data.exists) {
      return null;
    }
    final kUser = kUserFromJson(jsonEncode(data.data()));
    return kUser;
  }

  Future<List<KUser>> getAllUsers() async {
    var users = await db.collection("users").limit(10).get();
    List<KUser> usersList = [];
    for (var user in users.docs) {
      final kUser = kUserFromJson(jsonEncode(user.data()));
      usersList.add(kUser);
    }
    return usersList;
  }

  Future<void> sendMessage(String message, KUser receiver) async {
    var senderUid = FirebaseAuth.instance.currentUser!.uid;
    var data = {
      "message": message,
      "senderUid": senderUid,
      "receiverUid": receiver.uid,
      "timestamp": FieldValue.serverTimestamp()
    };
    String myId = LocalStorage().getData(AppStrings.mySecretKey);
    if (myId != "") {
      int docId = int.parse(myId) * int.parse(receiver.key);
      await db
          .collection("messages")
          .doc(docId.toString())
          .collection("messages")
          .add(data);
    }
  }

  Stream<QuerySnapshot> getMessages(KUser user, String myId) {
    int docId = int.parse(myId) * int.parse(user.key);
    return db
        .collection("messages")
        .doc(docId.toString())
        .collection("messages")
        .limit(30)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<void> updateUsersChatList(KUser user, String message) async {
    var myData = {"user": user.toJson(), "message": message};
    String myKey = LocalStorage().getData(AppStrings.mySecretKey);
    var otherUserData = {
      "message": message,
      "user": {
        "username": FirebaseAuth.instance.currentUser!.displayName,
        "photoURL": FirebaseAuth.instance.currentUser!.photoURL,
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "email": FirebaseAuth.instance.currentUser!.email,
        "key": myKey
      }
    };
    await db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("chats")
        .doc(user.uid)
        .set(myData, SetOptions(merge: true));

    await db
        .collection("users")
        .doc(user.uid)
        .collection("chats")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(otherUserData, SetOptions(merge: true));
  }

  Future<List<ThreadsModel>> getFriends() async {
    var users = await db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("chats")
        .limit(10)
        .get();

    List<ThreadsModel> usersList = [];
    for (var user in users.docs) {
      final kUser = kUserFromJson(jsonEncode(user.data()['user']));
      usersList.add(ThreadsModel(user: kUser, message: user.data()['message']));
    }
    return usersList;
  }
}

class ThreadsModel {
  KUser user;
  String message;
  ThreadsModel({
    required this.user,
    required this.message,
  });
}
