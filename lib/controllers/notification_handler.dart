import 'dart:developer' as dev;
import 'dart:async';
import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mca_leads_management_mobile/models/interfaces/common_interface.dart';

class NotificationHandler {
  static bool _isFirebaseServiceStarted = false;
  static late StreamSubscription<RemoteMessage> _onFirebaseMessageListener;

  static void start() async {
    if (_isFirebaseServiceStarted) {
      return;
    }
    try {
      _isFirebaseServiceStarted = true;
      await Firebase.initializeApp();
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? fcmToken = await messaging.getToken();
      dev.log("fcm token: $fcmToken");
      CommonInterface().updateToken(fcmToken ?? "");
      // await AdminInterface() //TODO: Send FCM to server
      //     .registerUserFCM(currentStaff.username, await messaging.getToken());
      if (Platform.isIOS) {
        await messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );
      }
      _onFirebaseMessageListener =
          FirebaseMessaging.onMessage.listen((RemoteMessage event) {
        // if (event == null || event.data == null) {
        //   return;
        // }
        String title =
            event.notification?.title ?? "Unknown notification title";
        String body = event.notification?.body ?? "Unknown notification body";
        dev.log("notofcation title:" + title);
      }, onError: (error) {}, cancelOnError: false);
    } catch (e) {
      _isFirebaseServiceStarted = false;
    }
  }

  static Future<void> stop() async {
    await _onFirebaseMessageListener.cancel();
    _isFirebaseServiceStarted = false;
  }
}

class NotificationData {
  NotificationEventType? eventType;
  int sessionId;

  NotificationData({required this.eventType, required this.sessionId});

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      sessionId: int.parse(json['sessionId']),
      eventType: EnumToString.fromString(
          NotificationEventType.values, json['eventType']),
    );
  }
}

enum NotificationEventType {
  newOffer //TODO: Add more notification events as needed
}
