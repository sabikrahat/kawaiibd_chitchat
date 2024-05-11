import 'package:flutter/material.dart';
import 'package:kawaiibd_flutterfire_task/app.routes.dart';
import 'package:kawaiibd_flutterfire_task/go.routes.dart';

import '../../config/constants.dart';
import '../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import '../../shared/show_toast/timer.snackbar/show.timer.snackbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const name = 'home';
  static const label = appName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(appName)),
      body: Center(
        child: Column(
          mainAxisAlignment: mainCenter,
          children: [
            const Text('Hello World!'),
            const SizedBox(height: 15),
            const Text('Welcome to $appName'),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => context.goPush(
                  '${AppRoutes.profileRoute}/${DateTime.now().millisecondsSinceEpoch}'),
              child: const Text('Go to Profile'),
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
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          context.goPush(AppRoutes.settingsRoute);
        },
        child: const Icon(Icons.settings),
      ),
    );
  }
}
