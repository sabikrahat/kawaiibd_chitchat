import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/constants.dart';
import '../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import '../../shared/show_toast/timer.snackbar/show.timer.snackbar.dart';
import '../profile/profile.dart';
import '../settings/view/setting.view.dart';

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
            onPressed: () => context.goNamed(SettingsView.name),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: mainCenter,
          children: [
            const Text('Hello World!'),
            const SizedBox(height: 15),
            const Text('Welcome to $appName'),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => context.goNamed(
                ProfileView.name,
                pathParameters: {
                  'uid': '${DateTime.now().millisecondsSinceEpoch}'
                },
              ),
              child: const Text('Go to Profile'),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => context.goNamed(SettingsView.advancedName),
              child: const Text('Settings Advanced'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => showTimerSnackbar('Just for testing'),
              child: const Text('Show Timer Snacbar'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => showAwesomeSnackbar(
                'Just for testing!',
                MessageType.success,
              ),
              child: const Text('Show Awesome Snacbar'),
            ),
          ],
        ),
      ),
    );
  }
}
