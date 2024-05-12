import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/constants.dart';
import '../../shared/page_not_found/page_not_found.dart';

class MessagingView extends ConsumerWidget {
  const MessagingView({super.key, required this.uid});

  static const name = 'message';
  static const label = 'Message - $appName';

  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (uid == 'no-uid-found') {
      return const KPageNotFound(error: '404 - Page not found!');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messaging'),
      ),
      body: const Center(
        child: Text('Messaging View'),
      ),
    );
  }
}
