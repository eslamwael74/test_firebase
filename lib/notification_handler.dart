import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
new FlutterLocalNotificationsPlugin();

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print("onBackgroundMessage: $message");
  return Future<void>.value();
}


Future onSelectNotification(String payload) async {
}

class NotificationHandler {
  FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;
  static final NotificationHandler _singleton =
  new NotificationHandler._internal();

  factory NotificationHandler() {
    return _singleton;
  }
  NotificationHandler._internal();

  initializeFcmNotification() async {
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      _saveDeviceToken();
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {

      },
      onBackgroundMessage:
      TargetPlatform.iOS == 'ios' ? null : myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    String fcmToken = await _fcm.getToken();
    print("FCM_TOKEN: $fcmToken");
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
  }
}