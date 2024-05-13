import 'package:firebase_core/firebase_core.dart';

import 'firebase.options.dart';

// const serverKey =
//     'AAAAZNMRMlg:APA91bFptn2YQGXvgmXUctT5KthezWKXTXpktX24C0aL0hIrK-k0N2zbXUAyIUxqKYAKe-Q9rzgK6ul2RRHp2FGtR9xDa4mP_MAAtR4jImu94BRhzbf56dIMOtuVzW5Ll2GuqL0HBj0c';

class FirebaseUtils {
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

//   final _firebaseMessaging = FirebaseMessaging.instance;

//   Future<String?> getDeviceToken() async => await _firebaseMessaging.getToken();

//   final _androidChannel = const AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     description: 'This channel is used for important notifications.',
//     importance: Importance.high,
//   );

//   final _localNotifications = FlutterLocalNotificationsPlugin();

//   void _handleMessage(RemoteMessage? message) {
//     log.f('>> Foreground Message: ${message?.messageId}');
//     log.f('>> Title: ${message?.notification?.title}');
//     log.f('>> Body: ${message?.notification?.body}');
//     log.f('>> Data: ${message?.data}');
//     if (message == null) return;
//     if (message.data.isEmpty) return;
//     globalCtx?.goPush('${AppRoutes.messageRoute}/${message.data['uid']}');
//   }

//   Future _initLocalNotifications() async {
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const ios = DarwinInitializationSettings();
//     const macos = DarwinInitializationSettings();
//     const linux =
//         LinuxInitializationSettings(defaultActionName: 'kawaiibd-chitchat');
//     const settings = InitializationSettings(
//         android: android, iOS: ios, linux: linux, macOS: macos);

//     await _localNotifications.initialize(settings,
//         onDidReceiveNotificationResponse: (response) {
//       final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
//       _handleMessage(message);
//     });

//     final androidPlatform =
//         _localNotifications.resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>();

//     final iosPlatform =
//         _localNotifications.resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>();

//     final macosPlatform =
//         _localNotifications.resolvePlatformSpecificImplementation<
//             MacOSFlutterLocalNotificationsPlugin>();

//     final linuxPlatform =
//         _localNotifications.resolvePlatformSpecificImplementation<
//             LinuxFlutterLocalNotificationsPlugin>();

//     await androidPlatform?.createNotificationChannel(_androidChannel);
//     await iosPlatform?.requestPermissions();
//     await macosPlatform?.requestPermissions();
//     await linuxPlatform?.getActiveNotifications();
//   }

//   Future _initPushNotification() async {
//     await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     _firebaseMessaging.getInitialMessage().then(_handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       if (notification == null) return;
//       _localNotifications.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             _androidChannel.id,
//             _androidChannel.name,
//             channelDescription: _androidChannel.description,
//             importance: _androidChannel.importance,
//             icon: '@mipmap/ic_launcher',
//           ),
//           iOS: const DarwinNotificationDetails(),
//           macOS: const DarwinNotificationDetails(),
//           linux: const LinuxNotificationDetails(),
//         ),
//         payload: jsonEncode(message.toMap()),
//       );
//     });
//   }

//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       provisional: false,
//       sound: true,
//     );
//     final token = await getDeviceToken();
//     log.i('>> Device Token: $token');
//     _initLocalNotifications();
//     _initPushNotification();
//   }

//   Future<void> sendNotification({
//     required String? token,
//     required String title,
//     required String body,
//     required String? uid,
//   }) async {
//     if (token == null) {
//       log.e('>> Error: Token is null');
//       EasyLoading.showToast('Token is null',
//           toastPosition: EasyLoadingToastPosition.bottom);
//       return;
//     }
//     try {
//       await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'key=$serverKey',
//         },
//         body: jsonEncode({
//           'priority': 'high',
//           'notification': {
//             'title': title,
//             'body': body,
//           },
//           'data': {'uid': uid},
//           'to': token,
//         }),
//       );
//     } catch (e) {
//       log.e('>> Error: $e');
//       EasyLoading.showToast('$e',
//           toastPosition: EasyLoadingToastPosition.bottom);
//     }
//   }
// }

// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   log.f('>> Background Message: ${message.messageId}');
//   log.f('>> Title: ${message.notification?.title}');
//   log.f('>> Body: ${message.notification?.body}');
//   log.f('>> Data: ${message.data}');
}
