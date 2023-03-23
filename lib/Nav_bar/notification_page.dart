import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  List<NotificationModel> notiList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: mainTheme,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildNotificationItem(),
          )
        ],
      ),
    );
  }

  Widget _buildNotificationItem() {
    return FutureBuilder<List<NotificationModel>>(
      future: fetchAllNoti(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<NotificationModel> notifications =
              snapshot.data!.reversed.toList();
          if (notifications.isNotEmpty) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListView.builder(
                // reverse: true,
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notificaiton = notifications[index];
                  return ListTile(
                    leading: Icon(Icons.event),
                    title: Text(
                      notificaiton.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(notificaiton.content),
                    // trailing: Icon(Icons.arrow_forward_ios),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text('There is no notification'),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<List<NotificationModel>> fetchAllNoti() async {
    final storage = new FlutterSecureStorage();
    final idStudent = int.tryParse(await storage.read(key: 'idStudent') ?? '');
    final response = await http.get(Uri.parse(
        "https://event-project.herokuapp.com/api/notifications/student/$idStudent"));

    final responseData = json.decode(response.body) as List;
    // print('responseData: $responseData');
    if (response.statusCode == 200) {
      return responseData.map((e) => NotificationModel.fromJson(e)).toList();
    } else {
      throw Exception("Fail to fetch");
    }
  }
}
