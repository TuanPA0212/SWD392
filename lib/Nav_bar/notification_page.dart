import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/notification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late SharedPreferences prefs;
  String? notiTitle;
  String? notiContent;

  // String? notiTitle;
  // String? notiContent;

  void fetchNoti() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? title = prefs.getString('notiTitle');
    // String? content = prefs.getString('notiContent');
    // setState(() {
    //   notiTitle = title;
    //   notiContent = content;
    // });
    // print(notiTitle);
    // print(notiContent);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notiTitle = message.notification?.title;
      final notiContent = message.notification?.body;

      await prefs.setString('notiTitle', notiTitle ?? '');
      await prefs.setString('notiContent', notiContent ?? '');

      setState(() {
        this.notiTitle = notiTitle;
        this.notiContent = notiContent;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchNoti();
    SharedPreferences.getInstance().then((sharedPrefs) {
      prefs = sharedPrefs;
      setState(() {
        notiTitle = prefs.getString('notiTitle') ?? null;
        notiContent = prefs.getString('notiContent') ?? null;
      });
    });

    print(notiTitle);
    print(notiContent);
    // SharedPreferences.getInstance().then((prefs) {
    //   setState(() {
    //     notiTitle = prefs.getString('notiTitle') ?? null;
    //   });
    // });
    // SharedPreferences.getInstance().then((prefs2) {
    //   setState(() {
    //     notiContent = prefs2.getString('notiContent') ?? null;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      // List<>
      body: ListView(
        children: [
          _buildNotificationItem(
            notiTitle ?? '',
            notiContent ?? '',
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

  // Future<void> fetchNoti() async {
  //   final url = "https://event-project.herokuapp.com/notifications";
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   print(response.body);
  //   print(response.statusCode);
  //   // final body = response.body;
  //   // final json = jsonDecode(body);
  //   // setState(() {
  //   //   notifications = json['']
  //   // });
  // }
}
