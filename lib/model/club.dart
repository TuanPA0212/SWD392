import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Club {
  final int clubId;
  final int campusId;
  final String name;
  final String abbreviation;
  final DateTime establishedDate;
  final int totalMembers;

  Club(
      {required this.clubId,
      required this.campusId,
      required this.name,
      required this.abbreviation,
      required this.establishedDate,
      required this.totalMembers});

  factory Club.fromJson(Map<String, dynamic> json) {
    print(json['establishedDate']);
    print(json['abbreviation']);
    return Club(
      clubId: json['clubId'] ?? 0,
      campusId: json['campusId'] ?? 0,
      name: json['name'],
      establishedDate: json['established_date'] != null
          ? DateTime.parse(json['established_date'])
          : DateTime.now(),
      abbreviation: json['abbreviation'],
      totalMembers: json['totalMembers'],
    );
  }
}
