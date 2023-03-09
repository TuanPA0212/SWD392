import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:swd_project/Nav_bar/notification_page.dart';
import 'package:swd_project/widgets/badge.dart';
import 'package:swd_project/widgets/grid_clubs.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../model//club.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  List<String> listCampus = ["HCM", "HN", "DN"];
  String? selectedVal = "HCM";
  List<Club> clubList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Club Page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          SizedBox(
            width: 240,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 3, color: Colors.blue))),
              value: selectedVal,
              items: listCampus
                  .map((campus) => DropdownMenuItem<String>(
                        child: Text(campus),
                        value: campus,
                      ))
                  .toList(),
              onChanged: (campus) {
                setState(() {
                  selectedVal = campus;
                });
              },
            ),
          ),
          Expanded(child: getClubGridView()),
        ],
      ),
    );
  }

  Widget getClubGridView() {
    return FutureBuilder<List<Club>>(
      future: fetchClubs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Club> clubs = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: ListView.builder(
              itemCount: clubs.length,
              itemBuilder: (BuildContext context, int index) {
                return GridClubs(
                  name: clubs[index].name,
                  clubId: clubs[index].clubId,
                  campusId: clubs[index].campusId,
                  abbreviation: clubs[index].abbreviation,
                  establishedDate: clubs[index].establishedDate,
                  totalMembers: clubs[index].totalMembers,
                );
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<List<Club>> fetchClubs() async {
    var response = await http
        .get(Uri.parse("https://event-project.herokuapp.com/api/club/1"));
    print(response.body);
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => Club.fromJson(e))
          .toList();
    } else {
      throw Exception("Fail to fetch");
    }
  }
}
