import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kawaiibd_flutterfire_task/src/db/db.dart';
import 'package:kawaiibd_flutterfire_task/src/modules/messaging/model/message.dart';
import 'package:kawaiibd_flutterfire_task/src/modules/messaging/provider/messaging.dart';
import 'package:kawaiibd_flutterfire_task/src/modules/settings/model/settings.model.dart';
import 'package:kawaiibd_flutterfire_task/src/utils/extensions/extensions.dart';

import '../../../config/constants.dart';
import '../../../shared/page_not_found/page_not_found.dart';

class MessagingView extends ConsumerWidget {
  const MessagingView({super.key, required this.uid});

  static const name = 'message';
  static const label = 'Message - $appName';

  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (uid == 'no-uid-found') {
      return const KPageNotFound(error: '404 - Page not found!');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messaging'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ref.watch(messagingProvider(uid)).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => KPageNotFound(error: err.toString()),
              data: (snapshot) {
                final notifier = ref.watch(messagingProvider(uid).notifier);
                final messages = snapshot.docs.map((e) => e.data()).toList();
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (_, index) => _MessageTile(
                          messages[index],
                          previous: index + 1 < messages.length
                              ? messages[index + 1]
                              : null,
                          next: index - 1 >= 0 ? messages[index - 1] : null,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              autofocus: false,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 3,
                              controller: notifier.cntrlr,
                              style: context.text.bodyMedium,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                  left: 8.0,
                                  top: 5.0,
                                  bottom: 5.0,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: context.theme.primaryColor),
                                  borderRadius: borderRadius10,
                                ),
                                hintText: "Type your message...",
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                  borderRadius: borderRadius10,
                                ),
                              ),
                            ),
                          ),
                          if (notifier.isSendable)
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: InkWell(
                                onTap: () async => await notifier.sendMessage(),
                                child: Icon(
                                  Icons.send,
                                  color: context.theme.primaryColor,
                                  size: 26.0,
                                ),
                              ),
                            )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile(this.message, {this.previous, this.next});

  final MessageModel? previous;
  final MessageModel message;
  final MessageModel? next;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        mainAxisAlignment: mainEnd,
        children: [
          if (previous == null ||
              previous!.created.toLocal().day != message.created.toLocal().day)
            Text(
              appSettings.getDateFormat.format(message.created.toLocal()),
            ),
          Row(
            mainAxisAlignment: message.isMeSender ? mainEnd : mainStart,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: context.width * 0.75),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: message.isMeSender
                      ? context.theme.primaryColor
                      : Colors.grey[800],
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0),
                    bottomLeft: message.isMeSender
                        ? const Radius.circular(20.0)
                        : const Radius.circular(0.0),
                    bottomRight: message.isMeSender
                        ? const Radius.circular(0.0)
                        : const Radius.circular(20.0),
                  ),
                ),
                child: Text(
                  message.message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Align(
            alignment: message.isMeSender
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(
              appSettings.getTimeFormat.format(message.created.toLocal()),
              style: context.text.labelSmall!.copyWith(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
