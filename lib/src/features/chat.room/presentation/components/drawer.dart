import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constant/app.config.dart';
import '../../../../local.db/db.dart';
import '../../../../components/animations_widget/animated_widget_shower.dart';
import '../../../../components/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/themes/themes.dart';
import '../../../auth/domain/user.dart';
import '../../../settings/domain/theme/theme.model.dart';
import '../../../settings/data/theme.provider.dart';
import '../../../settings/presentation/basic/about.tile.dart';
import '../../../settings/presentation/basic/signout.tile.dart';
import '../../data/chat.room.dart';
import 'search.delegate.dart';

class KDrawer extends ConsumerWidget {
  const KDrawer({super.key, this.uid});

  final String? uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = uid ?? FirebaseAuth.instance.currentUser!.uid;
    return ref.watch(singleUserStreamProvider(id)).when(
          loading: riverpodLoading,
          error: riverpodError,
          data: (snapshot) {
            final user = snapshot.data();
            return Drawer(
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: context.theme.primaryColor,
                    ),
                    accountName: Text(user?.name ?? 'No Name',
                        style: const TextStyle(fontSize: 15.0)),
                    accountEmail: Text(user?.email ?? 'No Email',
                        style: const TextStyle(fontSize: 14.0)),
                    currentAccountPicture: user?.imageWidgetWithSize(65),
                    otherAccountsPictures: [
                      IconButton(
                        icon: Icon(
                          appSettings.theme.isDark
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          color: white,
                        ),
                        onPressed: () =>
                            ref.read(themeProvider.notifier).changeTheme(),
                      ),
                    ],
                  ),
                  KListTile(
                    leading: AnimatedWidgetShower(
                      size: 30.0,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset(
                          'assets/svgs/employee.svg',
                          colorFilter: context.theme.primaryColor.toColorFilter,
                          semanticsLabel: 'Signout',
                        ),
                      ),
                    ),
                    title: const Text(
                      'Find Users',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () async {
                      context.pop();
                      await showSearch(
                          context: context, delegate: SearchUsers());
                    },
                  ),
                  const SignoutTile(),
                  const AboutTile(),
                ],
              ),
            );
          },
        );
  }
}
