import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/app.config.dart';
import '../../../constant/constants.dart';
import '../../../components/page_not_found/page_not_found.dart';
import '../../../utils/extensions/extensions.dart';
import '../../chat.room/presentation/components/drawer.dart';
import '../data/messaging.dart';
import 'components/app.bar.dart';
import 'components/tile.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: KAppBar(uid),
        endDrawer: KDrawer(uid: uid),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: ref.watch(messagingProvider(uid)).when(
                loading: riverpodLoading,
                error: riverpodError,
                data: (snapshot) {
                  final notifier = ref.watch(messagingProvider(uid).notifier);
                  final messages = snapshot.docs.map((e) => e.data()).toList();
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (_, index) => MessageTile(
                            messages[index],
                            previous: index + 1 < messages.length
                                ? messages[index + 1]
                                : null,
                            next: index - 1 >= 0 ? messages[index - 1] : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
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
                                style: context.text.titleMedium,
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
                              IconButton(
                                onPressed: () async =>
                                    await notifier.sendMessage(),
                                icon: Icon(
                                  Icons.send,
                                  color: context.theme.primaryColor,
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
        ),
      ),
    );
  }
}
