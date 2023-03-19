import 'dart:convert';
import 'package:http/http.dart' as http;

List<NotificationModel> notifications = [];

class NotificationModel {
  String title;
  String content;

  NotificationModel({required this.title, required this.content});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] ?? "",
      content: json['content'] ?? "",
    );
  }
}
