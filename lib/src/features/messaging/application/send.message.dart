import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/extensions/extensions.dart';

import '../../../constant/get.platform.dart';
import '../../../firebase.module/fcm.utils.dart';
import '../../chat.room/data/chat.room.dart';
import '../data/messaging.dart';
import '../domain/message.dart';

Future<void> sendMessageService(MessagingProvider notifier, Ref ref)async {
  final message = notifier.cntrlr.text.trim();
  if (message.isNotNullOrEmpty) {
    await MessageModel(
      message: message,
      senderId: notifier.senderId,
      receiverId: notifier.receiverId,
      created: DateTime.now().toUtc(),
    ).saveFrBs();
    notifier.cntrlr.clear();
    if (pt.isNotMobile || notifier.receiver?.token == null) return;
    final s =
        (await ref.watch(singleUserStreamProvider(notifier.senderId).future)).data();
    await FcmUtils().sendNotification(
      token: notifier.receiver?.token,
      title: s?.name ?? 'New Message',
      body: message,
      uid: notifier.senderId,
    );
  }
}