import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/constants.dart';
import '../../../utils/extensions/extensions.dart';
import '../data/auth.dart';
import 'components/app.bar.dart';
import 'components/button.dart';
import 'components/form.dart';
import 'components/image.select.dart';
import 'components/signup.text.dart';

class AuthenticationView extends ConsumerWidget {
  const AuthenticationView({this.isSignup = false, super.key});

  static const name = 'authentication';
  static const signinName = 'signin';
  static const signupName = 'signup';

  static const label = 'Authentication - $appName';

  final bool isSignup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authenticationPd(isSignup));
    final notifier = ref.read(authenticationPd(isSignup).notifier);
    return Scaffold(
      appBar: AuthAppBar(notifier),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: min(400, context.width),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5.0,
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 10.0),
                    duration: const Duration(milliseconds: 200),
                    child: Column(
                      mainAxisSize: mainMin,
                      children: [
                        AuthImageSelect(notifier),
                        AuthForm(notifier),
                        AuthSignupText(notifier),
                        AuthButton(notifier),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
