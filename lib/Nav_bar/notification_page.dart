import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

import '../model/notification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    fetchNoti();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView(
        children: [
          _buildNotificationItem(
            'New message',
            'You have a new message from John.',
            Icons.message,
          ),
          _buildNotificationItem(
            'New event',
            'You have a new event invitation from David.',
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

  Future<void> fetchNoti() async {
    final url = "https://event-project.herokuapp.com/notifications";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    print(response.statusCode);
    // final body = response.body;
    // final json = jsonDecode(body);
    // setState(() {
    //   notifications = json['']
    // });
  }
}
