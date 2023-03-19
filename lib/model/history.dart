import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class History {
  final int eventId;
  final String name;
  final String location;
  final String img;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime registrationDate;
  final DateTime checkin;
  final Null checkout;

  History(
      {required this.eventId,
      required this.name,
      required this.location,
      required this.img,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.registrationDate,
      required this.checkin,
      required this.checkout});

  factory History.fromJson(Map<String, dynamic> json) => History(
        eventId: json["event_id"] ?? 0,
        name: json["name"] ?? '',
        location: json["location"] ?? '',
        img: json["img"] ?? '',
        description: json["description"] ?? '',
        startDate: json['start_date'] != null
            ? DateTime.parse(json["start_date"])
            : DateTime.now(),
        endDate: json['end_date'] != null
            ? DateTime.parse(json["end_date"])
            : DateTime.now(),
        registrationDate: json['registration_date'] != null
            ? DateTime.parse(json["registration_date"])
            : DateTime.now(),
        checkin: json['checkin'] != null
            ? DateTime.parse(json["checkin"])
            : DateTime.now(),
        checkout: json["checkout"] ?? '',
      );
}
