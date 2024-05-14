import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/extensions/extensions.dart';
import '../../auth/domain/user.dart';
import '../../chat.room/data/chat.room.dart';
import '../application/send.message.dart';
import '../domain/message.dart';

typedef MessagingNotifier = StreamNotifierProviderFamily<MessagingProvider,
    QuerySnapshot<MessageModel>, String>;

final messagingProvider = MessagingNotifier(MessagingProvider.new);

class MessagingProvider
    extends FamilyStreamNotifier<QuerySnapshot<MessageModel>, String> {
  final cntrlr = TextEditingController();
  @override
  Stream<QuerySnapshot<MessageModel>> build(String arg) {
    listener();
    return MessageModel.ref(arg)
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

  Future<void> sendMessage() async => await sendMessageService(this, ref);
}
