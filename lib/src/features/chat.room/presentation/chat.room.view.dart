import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/k_list_tile.dart/k_list_tile.dart';
import '../../../constant/app.config.dart';
import '../../../constant/constants.dart';
import '../../../constant/get.platform.dart';
import '../../../firebase.module/fcm.utils.dart';
import '../../../routing/app.routes.dart';
import '../../../routing/go.routes.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/themes/themes.dart';
import '../../auth/domain/user.dart';
import '../data/chat.room.dart';
import '../domain/chat.room.dart';
import 'components/drawer.dart';
import 'components/search.delegate.dart';

class ChatRoomView extends HookWidget {
  const ChatRoomView({super.key});

  static const name = 'chatroom';
  static const label = appName;

  @override
  Widget build(BuildContext context) {
    final isMobile = pt.isMobile;

    useEffect(() {
      if (isMobile) FcmUtils().init(context);
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.goPush(AppRoutes.settingsRoute),
          ),
        ],
      ),
      drawer: const KDrawer(),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async =>
            await showSearch(context: context, delegate: SearchUsers()),
        child: const Icon(Icons.add, color: white),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(recentUsersStreamProvider).when(
          loading: riverpodLoading,
          error: riverpodError,
          data: (snapshot) {
            final chats = snapshot.docs.map((e) => e.data()).toList();
            if (chats.isEmpty) return const _NoChatsWidget();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (_, index) {
                  final chat = chats[index];
                  return Consumer(builder: (_, ref, __) {
                    final opponent = ref.watch(
                        singleUserStreamProvider(chat.opponentId)
                            .select((v) => v.value?.data()));
                    return KListTile(
                      title: Text(opponent?.name ?? '...',
                          style: context.text.titleMedium),
                      subtitle: Text(
                          chat.isMeSender
                              ? 'You: ${chat.lastMessage} '
                              : chat.lastMessage,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: context.text.bodyMedium!.copyWith(
                              fontWeight:
                                  chat.isMeSender ? null : FontWeight.bold)),
                      trailing: chat.isMeSender
                          ? null
                          : Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                borderRadius: borderRadius25,
                                color: context.theme.primaryColor,
                              ),
                            ),
                      leading: opponent?.imageWidget,
                      onTap: () => context.goPush(
                          '${AppRoutes.messageRoute}/${chat.opponentId}'),
                    );
                  });
                },
              ),
            );
          },
        );
  }
}

class _NoChatsWidget extends StatelessWidget {
  const _NoChatsWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(20.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          const Icon(Icons.people_outline, color: Colors.grey, size: 70.0),
          Text(
            'No recent chats found. Start a new chat by clicking the + button.',
            textAlign: TextAlign.center,
            style: context.text.titleLarge!.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
