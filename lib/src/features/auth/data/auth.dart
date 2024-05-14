import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import '../application/auth.api.service.dart';

typedef AuthenticationNotifier
    = AutoDisposeNotifierProviderFamily<AuthenticationPd, void, bool>;

final authenticationPd = AuthenticationNotifier(AuthenticationPd.new);

class AuthenticationPd extends AutoDisposeFamilyNotifier<void, bool> {
  final TextEditingController pwdConfirmCntrlr = TextEditingController();
  final TextEditingController emailCntrlr = TextEditingController();
  final TextEditingController nameCntrlr = TextEditingController();
  final TextEditingController pwdCntrlr = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool pwdConfirmObscure = true;
  bool pwdObscure = true;
  dynamic image;

  late bool isSignup;

  @override
  void build(bool arg) {
    isSignup = arg;
    if (!isProduction && !isSignup) {
      emailCntrlr.text = 'sabikrahat72428@gmail.com';
      pwdCntrlr.text = '@Rahat123';
      pwdConfirmCntrlr.text = '@Rahat123';
    }
  }

  void toggleIsSignup() {
    isSignup = !isSignup;
    ref.notifyListeners();
  }

  void togglePwdObscure() {
    pwdObscure = !pwdObscure;
    ref.notifyListeners();
  }

  void toggleConfirmPwdObscure() {
    pwdConfirmObscure = !pwdConfirmObscure;
    ref.notifyListeners();
  }

  void setImage(var img) {
    image = img;
    ref.notifyListeners();
  }

  void removeImage() {
    image = null;
    ref.notifyListeners();
  }

  void clear() {
    formKey = GlobalKey<FormState>();
    pwdConfirmCntrlr.clear();
    emailCntrlr.clear();
    nameCntrlr.clear();
    pwdCntrlr.clear();
    image = null;
    ref.notifyListeners();
  }

  Future<void> submit(BuildContext context) async =>
      isSignup ? await signup(context) : await signin(context);

  Future<void> signup(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    await frbsSignup(context, this);
  }

  Future<void> signin(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    await frbsSignin(context, this);
  }
}
