// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB0eSQoz-0aZhUvy_49NozvoNB1Bzz2LgQ',
    appId: '1:433037849176:web:c4ae7f6be9bf166ceb102d',
    messagingSenderId: '433037849176',
    projectId: 'kawaiibd-chitchat',
    authDomain: 'kawaiibd-chitchat.firebaseapp.com',
    storageBucket: 'kawaiibd-chitchat.appspot.com',
    measurementId: 'G-RK4T1Q3EE4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCWkTpedxPpfHBgQcDA45Mjo9a7zmuePvY',
    appId: '1:433037849176:android:e68bb380a9841740eb102d',
    messagingSenderId: '433037849176',
    projectId: 'kawaiibd-chitchat',
    storageBucket: 'kawaiibd-chitchat.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkW0RKqBaGEKTjfcn8jh36m8N2F7Q3KdY',
    appId: '1:433037849176:ios:94833dcdc39ddb7aeb102d',
    messagingSenderId: '433037849176',
    projectId: 'kawaiibd-chitchat',
    storageBucket: 'kawaiibd-chitchat.appspot.com',
    iosBundleId: 'com.sabikrahat.kawaiibdchitchat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCkW0RKqBaGEKTjfcn8jh36m8N2F7Q3KdY',
    appId: '1:433037849176:ios:94833dcdc39ddb7aeb102d',
    messagingSenderId: '433037849176',
    projectId: 'kawaiibd-chitchat',
    storageBucket: 'kawaiibd-chitchat.appspot.com',
    iosBundleId: 'com.sabikrahat.kawaiibdchitchat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB0eSQoz-0aZhUvy_49NozvoNB1Bzz2LgQ',
    appId: '1:433037849176:web:ed4e489c9be13e64eb102d',
    messagingSenderId: '433037849176',
    projectId: 'kawaiibd-chitchat',
    authDomain: 'kawaiibd-chitchat.firebaseapp.com',
    storageBucket: 'kawaiibd-chitchat.appspot.com',
    measurementId: 'G-JVS5YCWRHB',
  );
}
