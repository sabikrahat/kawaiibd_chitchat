import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../config/get.platform.dart';

import '../../../../../go.routes.dart';
import '../../../../config/app.config.dart';
import '../../../../config/constants.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../provider/messaging.dart';

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
                    // return KListTile(
                    //   title: Text(user?.name ?? 'No Name',
                    //       style: context.text.titleMedium),
                    //   subtitle: Text(user?.email ?? 'No Email',
                    //       style: context.text.bodyMedium),
                    //   leading: user?.imageWidget,
                    // );
                    return Row(
                      mainAxisAlignment: mainStart,
                      crossAxisAlignment: crossCenter,
                      children: [
                        if (user != null)
                          Container(
                            padding: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: context.theme.primaryColor,
                                  width: 1.5),
                            ),
                            child: ClipRRect(
                              borderRadius: borderRadius45,
                              child: user.avatar == null
                                  ? Container(
                                      height: 38.0,
                                      width: 38.0,
                                      color: context.theme.primaryColor
                                          .withOpacity(0.4),
                                      child: FittedBox(
                                        child: Text(
                                          '${user.name.split(' ').first.split('').first}${user.name.split(' ').last.split('').first}',
                                          style: TextStyle(
                                              color:
                                                  context.theme.primaryColor),
                                        ),
                                      ),
                                    )
                                  : FastCachedImage(
                                      height: 38.0,
                                      width: 38.0,
                                      url: user.avatar ?? '',
                                      loadingBuilder: (_, p) => Container(
                                        height: 38.0,
                                        width: 38.0,
                                        padding: const EdgeInsets.all(2.0),
                                        child: ClipRRect(
                                          borderRadius: borderRadius45,
                                          child: SpinKitThreeBounce(
                                            color: context.theme.primaryColor,
                                            size: 15.0,
                                          ),
                                        ),
                                      ),
                                      errorBuilder: (_, __, ___) =>
                                          const SizedBox(
                                        height: 38.0,
                                        width: 38.0,
                                        child: Icon(Icons.error),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                            ),
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
        ],
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(10.0),
    //   child: Row(
    //     mainAxisAlignment: mainSpaceBetween,
    //     children: [
    //       InkWell(
    //         borderRadius: borderRadius45,
    //         onTap: () => Scaffold.of(context).openDrawer(),
    //         child: Card(
    //           shape: roundedRectangleBorder45,
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(
    //                 horizontal: 10.0, vertical: 15.0),
    //             child: SvgPicture.asset(
    //               'assets/svgs/menu.svg',
    //             ),
    //           ),
    //         ),
    //       ),
    //       SvgPicture.asset(
    //         'assets/svgs/appbar-icon.svg',
    //       ),
    //       InkWell(
    //         borderRadius: borderRadius45,
    //         onTap: () async =>
    //             await context.fadePush(const CustomerNotificationView()),
    //         child: Card(
    //           shape: roundedRectangleBorder45,
    //           child: Padding(
    //             padding: const EdgeInsets.all(13.0),
    //             child: SvgPicture.asset(
    //               'assets/svgs/notification.svg',
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
