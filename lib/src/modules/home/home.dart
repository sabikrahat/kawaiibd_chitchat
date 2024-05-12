import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kawaiibd_flutterfire_task/app.routes.dart';
import 'package:kawaiibd_flutterfire_task/go.routes.dart';
import 'package:kawaiibd_flutterfire_task/src/modules/auth/model/user.dart';
import 'package:kawaiibd_flutterfire_task/src/utils/extensions/extensions.dart';

import '../../config/app.config.dart';
import '../../config/constants.dart';
import '../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../utils/themes/themes.dart';
import 'provider/home.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const name = 'home';
  static const label = appName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(appName)),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => context.goPush(AppRoutes.settingsRoute),
        child: const Icon(Icons.settings, color: white),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(usersStreamProvider).when(
          loading: riverpodLoading,
          error: riverpodError,
          data: (snapshot) {
            final users = snapshot.docs.map((e) => e.data()).toList();
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, index) {
                final user = users[index];
                return KListTile(
                  title: Text(user.name, style: context.text.titleMedium),
                  subtitle: Text(user.email, style: context.text.bodyMedium),
                  leading: user.imageWidget,
                  onTap: () =>
                      context.goPush('${AppRoutes.profileRoute}/${user.uid}'),
                );
              },
            );
          },
        );
  }
}
