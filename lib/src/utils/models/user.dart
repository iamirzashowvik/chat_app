// To parse this JSON data, do
//
//     final kUser = kUserFromJson(jsonString);

import 'dart:convert';

KUser kUserFromJson(String str) => KUser.fromJson(json.decode(str));

String kUserToJson(KUser data) => json.encode(data.toJson());

class KUser {
  String photoUrl;
  String uid;
  String email;
  String username;
  String key;

  KUser({
    required this.photoUrl,
    required this.uid,
    required this.email,
    required this.username,
    required this.key,
  });

  factory KUser.fromJson(Map<String, dynamic> json) => KUser(
        photoUrl: json["photoURL"],
        uid: json["uid"],
        email: json["email"],
        username: json["username"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "photoURL": photoUrl,
        "uid": uid,
        "email": email,
        "username": username,
        "key": key,
      };
}
