import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kawaiibd_flutterfire_task/src/modules/messaging/model/message.dart';
import 'package:kawaiibd_flutterfire_task/src/utils/extensions/extensions.dart';

import '../../auth/model/user.dart';

final userStreamProvider = StreamProvider.family(
    (_, String uid) => UserModel.singleDocRef(uid).snapshots());

typedef MessagingNotifier = StreamNotifierProviderFamily<MessagingProvider,
    QuerySnapshot<MessageModel>, String>;

final messagingProvider = MessagingNotifier(MessagingProvider.new);

class MessagingProvider
    extends FamilyStreamNotifier<QuerySnapshot<MessageModel>, String> {
  final cntrlr = TextEditingController();
  @override
  Stream<QuerySnapshot<MessageModel>> build(String arg) {
    listener();
    return MessageModel.collectionRef(arg).orderBy('created', descending: true).snapshots();
  }

  bool get isSendable => cntrlr.text.trim().isNotNullOrEmpty;

  String get senderId =>
      FirebaseAuth.instance.currentUser?.uid ?? 'no-uid-found';

  String get receiverId => arg;

  listener() => cntrlr.addListener(() => ref.notifyListeners());

  Future<void> sendMessage() async {
    final message = cntrlr.text.trim();
    if (message.isNotNullOrEmpty) {
      await MessageModel(
        message: message,
        senderId: senderId,
        receiverId: receiverId,
        created: DateTime.now().toUtc(),
      ).saveFrBs();
      cntrlr.clear();
    }
  }
}
