import 'dart:convert';
import 'package:http/http.dart' as http;

List<NotificationModel> notifications = [];

class NotificationModel {
  String title;
  String content;

  NotificationModel({required this.title, required this.content});

  // factory NotificationModel.fromJson(Map<String, dynamic> json) {
  //   // print(json['establishedDate']);
  //   // print(json['abbreviation']);
  //   return NotificationModel(

  //       // clubId: json['clubId'] ?? 0,
  //       // campusId: json['campusId'] ?? 0,
  //       // name: json['name'],
  //       // establishedDate: json['established_date'] != null
  //       //     ? DateTime.parse(json['established_date'])
  //       //     : DateTime.now(),
  //       // abbreviation: json['abbreviation'],
  //       // totalMembers: json['totalMembers'],
  //       );
  // }
}
// class NotificationItem {
//   final String title;
//   final String body;

//   NotificationItem({required this.title, required this.body});
//   factory NotificationItem.fromJson(Map<String, dynamic> json) {
//     return NotificationItem(
//       title: json['title'],
//       body: json['body'],
//     );
//   }
// }

// Future<List<NotificationItem>> fetchNotificationByAccountId(int id) async {
//   var response = await http
//       .get(Uri.parse("https://event-project.herokuapp.com/notifications"));
//   if (response.statusCode == 200) {
//     return (json.decode(response.body) as List)
//         .map((e) => NotificationItem.fromJson(e))
//         .toList();
//   } else {
//     throw Exception("Fail to fetch");
//   }
// }
