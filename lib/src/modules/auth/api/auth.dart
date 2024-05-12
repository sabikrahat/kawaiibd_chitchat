import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../model/user.dart';

import '../../../../go.routes.dart';
import '../../../firebase/upload.to.firebase.storage.dart';
import '../../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import '../../../utils/logger/logger_helper.dart';
import '../provider/auth.dart';

Future<void> frbsSignup(BuildContext context, AuthenticationPd notifier) async {
  EasyLoading.show(status: 'Creating account...');
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: notifier.emailCntrlr.text,
      password: notifier.pwdCntrlr.text,
    )
        .then((uc) async {
      await UserModel(
        uid: uc.user?.uid,
        name: notifier.nameCntrlr.text,
        email: notifier.emailCntrlr.text,
        avatar: await uploadImageToFirebae(notifier.image),
        created: DateTime.now().toUtc(),
      ).saveFrBs();
      EasyLoading.dismiss();
      goRouter.refresh();
      notifier.clear();
    });
    return;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  } catch (e) {
    log.e('User Creation: $e');
    if (!context.mounted) return;
    showAwesomeSnackbar(e.toString(), MessageType.failure);
    return;
  }
}

Future<void> frbsSignin(BuildContext context, AuthenticationPd notifier) async {
  EasyLoading.show(status: 'Matching Credentials...');
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: notifier.emailCntrlr.text,
      password: notifier.pwdCntrlr.text,
    )
        .then((uc) {
      EasyLoading.dismiss();
      goRouter.refresh();
      notifier.clear();
    });
    return;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  } catch (e) {
    log.e('User signin: $e');
    if (!context.mounted) return;
    showAwesomeSnackbar(e.toString(), MessageType.failure);
    return;
  }
}

Future<void> frbsResetPassword(BuildContext context, String email) async {
  EasyLoading.show(status: 'Sending email...');
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((_) {
      EasyLoading.dismiss();
      showAwesomeSnackbar(
        'Password reset email sent to $email',
        MessageType.success,
      );
    });
    return;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  }
}
