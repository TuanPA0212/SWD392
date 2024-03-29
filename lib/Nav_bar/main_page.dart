import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swd_project/Nav_bar/notification_page.dart';
import 'package:swd_project/Nav_bar/home_page.dart';
import 'package:swd_project/Nav_bar/blog_page.dart';
import 'package:swd_project/Nav_bar/profile_page.dart';
import 'package:swd_project/Nav_bar/club_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swd_project/common_widget/color.dart';
import '../widgets/badge.dart';
import 'club_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? mtoken = "";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    requestPermission();
    getDeviceToken();
    initInfor();
  }

  initInfor() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iosInitialize = const IOSInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    // subscribe to topic on each app start-up

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("Message: ${message.notification?.title}");
      print("Message body: ${message.notification?.body}");

      final notiTitle = message.notification?.title;
      final notiContent = message.notification?.body;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      SharedPreferences prefs2 = await SharedPreferences.getInstance();
      await prefs2.setString('notiTitle', notiTitle ?? '');
      await prefs.setString('notiContent', notiContent ?? '');
      // print(prefs2.getString('notiContent'));
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'dbfood',
        'dbfood',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
      );
      NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecifics,
          payload: message.data['body']);
    });
  }

  void getDeviceToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        // print("My device token is $mtoken");
      });
      saveDeviceToken(token!);
    });
  }

  final storage = FlutterSecureStorage();
  void saveDeviceToken(String token) async {
    await storage.write(key: 'device_token', value: token);
    // final dtoken = await storage.read(key: 'device_token');
    // print('dtoken $dtoken');
    await FirebaseFirestore.instance.collection("UserTokens").doc("User2").set({
      'token': token,
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance.subscribeToTopic('topic');
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      print("User declined or has not accepted permission");
    }
  }

// Nav-bar here
  List pages = [
    HomePage(),
    ClubPage(),
    // BlogPage(),
    MyHomePage(),
    ProfilePage(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Colors.blue,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.black38,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: mainTheme),
            BottomNavigationBarItem(
                icon: Icon(Icons.copyright_outlined),
                label: 'Club',
                backgroundColor: mainTheme),
            BottomNavigationBarItem(
                icon: Icon(Icons.article),
                label: 'Event',
                backgroundColor: mainTheme),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: mainTheme),
          ]),
    );
  }
}
