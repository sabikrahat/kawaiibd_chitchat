import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat.room.dart';

part 'message.ext.dart';
part 'message.ext.frbs.dart';

class MessageModel {
  String? id;
  final String message;
  final String senderId;
  final String receiverId;
  final DateTime created;

  MessageModel({
    this.id,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.created,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json[_Json.id],
      message: json[_Json.message],
      senderId: json[_Json.senderId],
      receiverId: json[_Json.receiverId],
      created: json[_Json.created] == null
          ? DateTime.now().toLocal()
          : DateTime.parse(json[_Json.created]).toLocal(),
    );
  }

  factory MessageModel.fromRawJson(String str) =>
      MessageModel.fromJson(json.decode(str));

  static CollectionReference<MessageModel> ref(String s) =>
      FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(createChatRoomId(s))
          .collection('chats')
          .withConverter<MessageModel>(
            fromFirestore: (s, _) =>
                MessageModel.fromJson(s.data()!)..id = s.id,
            toFirestore: (s, _) => s.toJson(),
          );

  @override
  String toString() {
    return 'MessageModel(id: $id, message: $message, senderId: $senderId, receiverId: $receiverId, created: $created)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const id = 'id';
  static const message = 'message';
  static const senderId = 'senderId';
  static const receiverId = 'receiverId';
  static const created = 'created';
}
