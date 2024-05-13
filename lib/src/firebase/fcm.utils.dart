import 'dart:convert';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:kawaiibd_flutterfire_task/src/config/get.platform.dart';

import '../../app.routes.dart';
import '../../go.routes.dart';
import '../utils/logger/logger_helper.dart';
import 'init.dart';

const serverKey =
    'AAAAZNMRMlg:APA91bFptn2YQGXvgmXUctT5KthezWKXTXpktX24C0aL0hIrK-k0N2zbXUAyIUxqKYAKe-Q9rzgK6ul2RRHp2FGtR9xDa4mP_MAAtR4jImu94BRhzbf56dIMOtuVzW5Ll2GuqL0HBj0c';

class FcmUtils {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotificationPlugin = FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.isAuthorized) {
      return log.i('User granted permission');
    } else if (settings.isProvisional) {
      log.i('User granted provisional permission');
    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      log.i('User declined or has not accepted permission');
    }
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    const android = AndroidInitializationSettings('@drawable/ic_notification');
    const ios = DarwinInitializationSettings();
    const initialize = InitializationSettings(android: android, iOS: ios);
    await _localNotificationPlugin.initialize(
      initialize,
      onDidReceiveNotificationResponse: (payload) {
        log.i('>> Rahat Rahat Response Payload: ${payload.payload}');
        handleMessage(context, message);
      },
    );
  }

  Future<String?> getDeviceToken() async =>
      pt.isNotMobile ? null : await _firebaseMessaging.getToken();

  void isTokenRefresh() async {
    _firebaseMessaging.onTokenRefresh.listen((String? token) {
      log.i('>> Device Token: $token');
    });
  }

  void init(BuildContext context) async {
    requestNotificationPermission();
    getDeviceToken().then((token) => log.i('>> Device Token: $token'));
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log.i('>> Rahar Rahat Foreground Message: ${message.messageId}');
      log.i('>> Title: ${message.notification?.title}');
      log.i('>> Body: ${message.notification?.body}');
      log.i('>> Data: ${message.data}');
      initLocalNotification(context, message);
      showNotification(message);
    });
    setupInteractMessage(context);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void showNotification(RemoteMessage message) async {
    final androidChannel = AndroidNotificationChannel(
      Random.secure().nextInt(1000).toString(),
      'High Importance Notification',
      importance: Importance.max,
    );
    final androidDetails = AndroidNotificationDetails(
      androidChannel.id,
      androidChannel.name,
      channelDescription: 'kawaiibd-chitchat-channel',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@drawable/ic_notification',
    );
    //
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    //
    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    //
    Future.delayed(const Duration(seconds: 0), () {
      _localNotificationPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
      );
    });
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    final message = await _firebaseMessaging.getInitialMessage();
    if (message != null) {
      log.i('>> Rahat Rahat Initial Message: ${message.messageId}');
      log.i('>> Title: ${message.notification?.title}');
      log.i('>> Body: ${message.notification?.body}');
      log.i('>> Data: ${message.data}');
      if (!context.mounted) return;
      handleMessage(context, message);
    }
    // when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log.i('>> Rahar Rahat Opened App Message: ${message.messageId}');
      log.i('>> Title: ${message.notification?.title}');
      log.i('>> Body: ${message.notification?.body}');
      log.i('>> Data: ${message.data}');
      if (!context.mounted) return;
      handleMessage(context, message);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    log.i('>> Raht Rahat Handle Message: ${message.messageId}');
    log.i('>> Title: ${message.notification?.title}');
    log.i('>> Body: ${message.notification?.body}');
    log.i('>> Data: ${message.data}');
    final uid = message.data['uid'];
    log.i('>> Rahat Rahat UID: $uid');
    context.goPush('${AppRoutes.messageRoute}/$uid');
  }

  Future<void> sendNotification({
    required String? token,
    required String title,
    required String body,
    required String? uid,
  }) async {
    if (token == null) {
      log.e('>> Error: Token is null');
      EasyLoading.showToast('Token is null',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode({
          'priority': 'high',
          'notification': {
            'title': title,
            'body': body,
          },
          'data': {'uid': uid},
          'to': token,
        }),
      );
    } catch (e) {
      log.e('>> Error: $e');
      EasyLoading.showToast('$e',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await FirebaseUtils.init();
  log.i('>> Rahat Rahat Background Message: ${message.messageId}');
  log.i('>> Title: ${message.notification?.title}');
  log.i('>> Body: ${message.notification?.body}');
  log.i('>> Data: ${message.data}');
}

extension CustomExt on NotificationSettings {
  bool get isAuthorized =>
      authorizationStatus == AuthorizationStatus.authorized;
  bool get isProvisional =>
      authorizationStatus == AuthorizationStatus.provisional;
  bool get isDenied => authorizationStatus == AuthorizationStatus.denied;
  bool get isNotDetermined =>
      authorizationStatus == AuthorizationStatus.notDetermined;
}
