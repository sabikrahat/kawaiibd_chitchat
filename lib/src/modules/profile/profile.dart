import 'package:flutter/material.dart';

import '../../config/constants.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.uid});

  static const name = 'profile';
  static const label = 'Profile - $appName';

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('Profile View'),
      ),
    );
  }
}
