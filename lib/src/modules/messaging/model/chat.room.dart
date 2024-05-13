import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'chat.room.ext.dart';
part 'chat.room.ext.frbs.dart';

class ChatRoom {
  String? id;
  final String lastMessage;
  final String lastSenderId;
  final List<String> users;
  final DateTime lastMessageTime;

  ChatRoom({
    this.id,
    required this.lastMessage,
    required this.lastSenderId,
    required this.users,
    required this.lastMessageTime,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json[_Json.id],
      lastMessage: json[_Json.lastMessage],
      lastSenderId: json[_Json.lastSenderId],
      users: List<String>.from(json[_Json.users]),
      lastMessageTime: json[_Json.lastMessageTime] == null
          ? DateTime.now().toLocal()
          : DateTime.parse(json[_Json.lastMessageTime]).toLocal(),
    );
  }

  factory ChatRoom.fromRawJson(String str) =>
      ChatRoom.fromJson(json.decode(str));

  static CollectionReference<ChatRoom> get ref => FirebaseFirestore.instance
      .collection('chatrooms')
      .withConverter<ChatRoom>(
        fromFirestore: (s, _) => ChatRoom.fromJson(s.data()!)..id = s.id,
        toFirestore: (s, _) => s.toJson(),
      );

  static Stream<QuerySnapshot<ChatRoom>> get queryRef => ref
      .where('users', arrayContains: FirebaseAuth.instance.currentUser!.uid)
      .orderBy('lastMessageTime', descending: true)
      .withConverter<ChatRoom>(
        fromFirestore: (s, _) => ChatRoom.fromJson(s.data()!)..id = s.id,
        toFirestore: (s, _) => s.toJson(),
      )
      .snapshots();

  @override
  String toString() {
    return 'Chatrooms(id: $id, lastMessage: $lastMessage, lastSenderId: $lastSenderId, users: $users, lastMessageTime: $lastMessageTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatRoom && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const id = 'id';
  static const lastMessage = 'lastMessage';
  static const lastSenderId = 'lastSenderId';
  static const users = 'users';
  static const lastMessageTime = 'lastMessageTime';
}
