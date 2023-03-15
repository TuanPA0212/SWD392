import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swd_project/common_widget/color.dart';
import '../model/notification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
// Model

  // late SharedPreferences prefs;
  // String? notiTitle;
  // String? notiContent;

  // void fetchNoti() async {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //     final notiTitle = message.notification?.title;
  //     final notiContent = message.notification?.body;

  //     await prefs.setString('notiTitle', notiTitle ?? '');
  //     await prefs.setString('notiContent', notiContent ?? '');

  //     final newNoti =
  //         NotificationModel(title: notiTitle ?? '', content: notiContent ?? '');
  //     setState(() {
  //       notifications.insert(0, newNoti);
  //     });
  //   });
  // }

  // void fetchNoti() async {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //     final notiTitle = message.notification?.title;
  //     final notiContent = message.notification?.body;

  //     await prefs.setString('notiTitle', notiTitle ?? '');
  //     await prefs.setString('notiContent', notiContent ?? '');

  //     setState(() {
  //       this.notiTitle = notiTitle;
  //       this.notiContent = notiContent;
  //     });
  //   });
  // }

  @override
  // void initState() {
  //   super.initState();
  //   fetchNoti();
  //   SharedPreferences.getInstance().then((sharedPrefs) {
  //     prefs = sharedPrefs;
  //     setState(() {
  //       notiTitle = prefs.getString('notiTitle') ?? null;
  //       notiContent = prefs.getString('notiContent') ?? null;
  //     });
  //   });

  //   print("title $notiTitle");
  //   print("content $notiContent");
  //   // SharedPreferences.getInstance().then((prefs) {
  //   //   setState(() {
  //   //     notiTitle = prefs.getString('notiTitle') ?? null;
  //   //   });
  //   // });
  //   // SharedPreferences.getInstance().then((prefs2) {
  //   //   setState(() {
  //   //     notiContent = prefs2.getString('notiContent') ?? null;
  //   //   });
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: mainTheme,
      ),
      // List<>
      body: ListView(
        children: [
          _buildNotificationItem(
            // notiTitle ?? '',
            // notiContent ?? '',
            "title",
            "content",
            Icons.event,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String title, String subtitle, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
