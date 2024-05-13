import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../go.routes.dart';
import '../../../../config/app.config.dart';
import '../../../../config/constants.dart';
import '../../../../config/get.platform.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../auth/model/user.dart';
import '../../../home/provider/home.dart';

class KAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const KAppBar(this.uid, {super.key});

  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: context.theme.primaryColor.withOpacity(0.2),
            blurRadius: 10.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          pt.isNotWeb
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => goRouter.pop(),
                )
              : const SizedBox(width: 12),
          Expanded(
            child: ref.watch(singleUserStreamProvider(uid)).when(
                  loading: riverpodLoading,
                  error: riverpodError,
                  data: (snapshot) {
                    final user = snapshot.data();
                    return Row(
                      mainAxisAlignment: mainStart,
                      crossAxisAlignment: crossCenter,
                      children: [
                        Column(
                          mainAxisAlignment: mainCenter,
                          children: [
                            user?.imageWidgetWithSize(38) ??
                                const SizedBox.shrink(),
                          ],
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: crossStart,
                            mainAxisAlignment: mainCenter,
                            children: [
                              Text(user?.name ?? 'No Name',
                                  style: context.text.titleMedium),
                              Text(user?.email ?? 'No Email',
                                  style: context.text.bodyMedium),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
          ),
          IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: const Icon(Icons.info_outline),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
