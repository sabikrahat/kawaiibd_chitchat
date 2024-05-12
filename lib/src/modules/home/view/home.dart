import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app.routes.dart';
import '../../../../go.routes.dart';
import '../../../config/app.config.dart';
import '../../../config/constants.dart';
import '../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/themes/themes.dart';
import '../../auth/model/user.dart';
import '../provider/home.dart';
import 'components/search.delegate.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const name = 'home';
  static const label = appName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () =>
                showSearch(context: context, delegate: SearchUsers()),
          ),
        ],
      ),
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
    return ref.watch(usersStreamProvider(null)).when(
          loading: riverpodLoading,
          error: riverpodError,
          data: (snapshot) {
            final users = snapshot.docs.map((e) => e.data()).toList().removeOwn;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (_, index) {
                  final user = users[index];
                  return KListTile(
                    title: Text(user.name, style: context.text.titleMedium),
                    subtitle: Text(user.email, style: context.text.bodyMedium),
                    leading: user.imageWidget,
                    onTap: () =>
                        context.goPush('${AppRoutes.messageRoute}/${user.uid}'),
                  );
                },
              ),
            );
          },
        );
  }
}
