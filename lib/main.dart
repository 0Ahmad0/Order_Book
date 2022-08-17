import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'dart:async';

import 'translations/codegen_loader.g.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', //id
    'High Importance Notifications', //title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("A bg message just showed up: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    sound: true,
    badge: true,
    announcement: false,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
  );
  FirebaseMessaging.onMessage.listen((event) {
    print(event.notification);
  });
  await GetStorage.init();
  Provider.debugCheckInvalidValueType = null;
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: [
        Locale("en"),
        Locale("ar"),
      ],
      fallbackLocale: Locale("en"),
      assetLoader:CodegenLoader(),
      child: MyApp(),
    ),
  );
}

/*
  _verfiyNumber(){

    auth.verifyPhoneNumber(
      phoneNumber: "+963993811331",
        verificationCompleted: (PhoneAuthCredential credential)async{
        await auth.signInWithCredential(credential).then((value) => print("Sucess"));
        },
        verificationFailed:(FirebaseAuthException exception){
        print(exception.message);
        },
        codeSent: (String verficationId, int? reSend){
          varfication = verficationId;

        },
        codeAutoRetrievalTimeout: (String verficationId){

        }
    );
  }

 */
