import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../firebase/init.dart';
import '../../../utils/extensions/extensions.dart';
import '../../auth/model/user.dart';
import '../model/message.dart';

final singleUserStreamProvider = StreamProvider.family(
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
    return MessageModel.collectionRef(arg)
        .orderBy('created', descending: true)
        .snapshots();
  }

  bool get isSendable => cntrlr.text.trim().isNotNullOrEmpty;

  String get senderId =>
      FirebaseAuth.instance.currentUser?.uid ?? 'no-uid-found';

  UserModel? get receiver => ref.watch(
      singleUserStreamProvider(receiverId).select((v) => v.value?.data()));

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
      await FirebaseUtils().sendNotification(
        token: receiver?.token,
        title: receiver?.name ?? 'New Message',
        body: message,
        uid: receiver?.uid,
      );
    }
  }
}
