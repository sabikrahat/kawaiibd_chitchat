import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../routing/go.routes.dart';
import '../../../../localization/loalization.dart';
import '../../../../components/animations_widget/animated_popup.dart';
import '../../../../components/animations_widget/animated_widget_shower.dart';
import '../../../../components/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';

class SignoutTile extends StatelessWidget {
  const SignoutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(
            'assets/svgs/signout.svg',
            colorFilter: context.theme.primaryColor.toColorFilter,
            semanticsLabel: 'Signout',
          ),
        ),
      ),
      title: Text(
        t.signout,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () async => await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SignoutPopup(),
      ),
    );
  }
}

class SignoutPopup extends StatelessWidget {
  const SignoutPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Signout'),
        content: const Text(
            'Are you sure you want to signout? You will be redirected to the login page'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style:
                  TextStyle(color: context.theme.dividerColor.withOpacity(0.8)),
            ),
          ),
          TextButton(
            onPressed: () async => await FirebaseAuth.instance
                .signOut()
                .then((value) => goRouter.refresh()),
            child: const Text('Confirm', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
