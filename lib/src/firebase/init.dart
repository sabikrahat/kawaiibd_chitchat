import 'package:firebase_core/firebase_core.dart';

import 'firebase.options.dart';

class FirebaseUtils {
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
