import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../constant/constants.dart';
import '../../../../localization/loalization.dart';
import '../../../../components/animations_widget/animated_popup.dart';
import '../../../../components/animations_widget/animated_widget_shower.dart';
import '../../../../components/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';

final infoProvider =
    FutureProvider((_) async => await PackageInfo.fromPlatform());

class AboutTile extends ConsumerWidget {
  const AboutTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(infoProvider).value;
    final bn = info?.buildNumber == '0' ? '' : '(${info?.buildNumber})';
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: SvgPicture.asset(
          'assets/svgs/about.svg',
          colorFilter: context.theme.primaryColor.toColorFilter,
          semanticsLabel: 'About',
        ),
      ),
      title: Text(
        t.about,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: info == null ? null : Text('${t.appTitle} ${info.version}$bn'),
      onTap: () async => await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => KAboutDialog('${info?.version}$bn'),
      ),
    );
  }
}

class KAboutDialog extends StatelessWidget {
  const KAboutDialog(this.version, {super.key});

  final String version;

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        title: Row(
          children: [
            Image.asset(
              'assets/icons/splash-icon-384x384.png',
              height: 52,
              width: 52,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: crossStart,
              children: [
                Text(
                  appName,
                  style: context.text.titleLarge,
                ),
                const SizedBox(height: 2),
                Text(
                  version,
                  style: context.text.labelMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '© 2024 $appName\n(A product of Rahat Corp.)',
                  style: context.text.labelMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            )
          ],
        ),
        content: SizedBox(
          width: min(400, context.width),
          child: Column(
            mainAxisSize: mainMin,
            children: [
              Text(
                '\nWelcome to the $appName app. This app is developed by Sabik Rahat for testing purposes. This app is not for commercial use. If you have any questions or suggestions, please contact me.',
                style: context.text.labelMedium,
                textAlign: TextAlign.justify,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '\n- Md. Sabik Alam Rahat.',
                  style: context.text.labelMedium!.copyWith(
                    color: context.theme.primaryColor,
                  ),
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style:
                  TextStyle(color: context.theme.dividerColor.withOpacity(0.8)),
            ),
          ),
          TextButton(
            onPressed: () => showLicensePage(context: context),
            child: Text(
              'View licenses',
              style: TextStyle(color: context.theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
