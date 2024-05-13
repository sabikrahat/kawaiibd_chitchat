import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kawaiibd_flutterfire_task/src/config/get.platform.dart';

import '../../../firebase/fcm.utils.dart';
import '../../../utils/extensions/extensions.dart';
import '../../auth/model/user.dart';
import '../../home/provider/home.dart';
import '../model/message.dart';

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
      if (pt.isNotMobile || receiver?.token == null) return;
      final s =
          (await ref.watch(singleUserStreamProvider(senderId).future)).data();
      await FcmUtils().sendNotification(
        token: receiver?.token,
        title: s?.name ?? 'New Message',
        body: message,
        uid: senderId,
      );
    }
  }
}
