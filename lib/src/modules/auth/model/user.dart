import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../config/constants.dart';
import '../../../utils/themes/themes.dart';

part 'user.ext.dart';
part 'user.ext.frbs.dart';

class UserModel {
  String? uid;
  String name;
  final String email;
  String? avatar;
  String? token;
  final DateTime created;

  UserModel({
    this.uid,
    required this.name,
    required this.email,
    this.avatar,
    this.token,
    required this.created,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json[_Json.uid],
      name: json[_Json.name],
      email: json[_Json.email],
      avatar: json[_Json.avatar],
      token: json[_Json.token],
      created: json[_Json.created] == null
          ? DateTime.now().toLocal()
          : DateTime.parse(json[_Json.created]).toLocal(),
    );
  }

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  static CollectionReference<UserModel> get collectionRef =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
            fromFirestore: (s, _) => UserModel.fromJson(s.data()!)..uid = s.id,
            toFirestore: (s, _) => s.toJson(),
          );
  //
  DocumentReference<UserModel> get ownDocRef => collectionRef.doc(uid);
  //
  static DocumentReference<UserModel> singleDocRef(String uid) => collectionRef.doc(uid);
  //
  static Stream<QuerySnapshot<UserModel>> docRef(String? email) => email == null
      ? collectionRef.snapshots()
      : collectionRef.where('email', isGreaterThanOrEqualTo: email).snapshots();
  //

  @override
  String toString() =>
      'UserModel(uid: $uid, name: $name, email: $email, avatar: $avatar, token: $token, created: $created)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.uid == uid;
  }

  @override
  int get hashCode => uid.hashCode;
}

class _Json {
  static const uid = 'uid';
  static const name = 'name';
  static const email = 'email';
  static const avatar = 'avatar';
  static const token = 'token';
  static const created = 'created';
}
