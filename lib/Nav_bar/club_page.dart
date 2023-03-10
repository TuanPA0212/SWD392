import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:swd_project/Nav_bar/notification_page.dart';
import 'package:swd_project/widgets/badge.dart';
import 'package:swd_project/widgets/grid_clubs.dart';

import 'package:flutter/material.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  List<Map> clubs = [
    {
      "img": "assets/images/macbook-air.png",
      "name": "Club 1",
      "member": 5,
      "location": "HCM"
    },
    {
      "img": "assets/images/14-promax.png",
      "name": "Club 2",
      "member": 10,
      "location": "HN"
    },
  ];

  List<String> listCampus = ["HCM", "HN", "DN"];
  String? selectedVal = "HCM";

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
                      borderSide:
                          const BorderSide(width: 3, color: Colors.blue))),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: ListView.builder(
                itemCount: clubs == null ? 0 : clubs.length,
                itemBuilder: (BuildContext context, int index) {
                  Map club = clubs[index];
                  return GridClubs(
                    img: club['img'],
                    name: club['name'],
                    member: club['member'],
                    location: club['location'],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
