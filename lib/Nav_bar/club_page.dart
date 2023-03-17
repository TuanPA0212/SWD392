import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:swd_project/Nav_bar/club_detail.dart';
import 'package:swd_project/Nav_bar/notification_page.dart';
import 'package:swd_project/common_widget/color.dart';
import 'package:swd_project/widgets/badge.dart';
import 'package:swd_project/widgets/grid_clubs.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../model//club.dart';

class ClubPage extends StatefulWidget {
  // const ClubPage({super.key});
  // final Club club;

  // const ClubPage({
  //   Key? key,
  //   required this.club,
  // }) : super(key: key);

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  Map<String, String> listCampus = {
    "1": "HCM",
    "2": "HN",
    "3": "DN",
  };
  String? selectedVal = "1";
  List<Club> clubList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainTheme,
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
                      borderSide: const BorderSide(
                          width: 3, color: Color.fromRGBO(183, 147, 219, 24)))),
              value: selectedVal,
              items: listCampus.entries
                  .map((entry) => DropdownMenuItem<String>(
                        child: Text(entry.value),
                        value: entry.key,
                      ))
                  .toList(),
              onChanged: (campus) {
                setState(() {
                  selectedVal = campus;
                });
              },
            ),
          ),
          Expanded(
              child: getClubGridView(int.tryParse(selectedVal ?? '0') ?? 0)),
        ],
      ),
    );
  }

  Widget getClubGridView(int selectedVal) {
    return FutureBuilder<List<Club>>(
      future: fetchClubs(selectedVal),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Club> clubs = snapshot.data!;
          // return Padding(
          //   padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          return InkWell(
            // onTap: () {
            //   Navigator.of(context).push(
            //     MaterialPageRoute(
            //       builder: (BuildContext context) {
            //         return ClubDetail(club: club);
            //       },
            //     ),
            //   );
            // },
            child: ListView.builder(
              itemCount: clubs.length,
              itemBuilder: (BuildContext context, int index) {
                onTap:
                () {
                  // Your onTap logic here
                };
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

  Future<List<Club>> fetchClubs(int campusID) async {
    final response = await http.get(Uri.parse(
        "https://event-project.herokuapp.com/api/club/campus/$campusID"));

    final responseData = json.decode(response.body) as List;
    // print('responseData: $responseData');
    if (response.statusCode == 200) {
      return responseData.map((e) => Club.fromJson(e)).toList();
    } else {
      throw Exception("Fail to fetch");
    }
  }
}
