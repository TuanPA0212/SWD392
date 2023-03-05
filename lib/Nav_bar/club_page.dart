import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:swd_project/Nav_bar/notification_page.dart';
import 'package:swd_project/widgets/badge.dart';
import 'package:swd_project/widgets/grid_clubs.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Club Page"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications,
              size: 22.0,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return NotificationPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView.builder(
          itemCount: clubs == null ? 0 : clubs.length,
          itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
            Map club = clubs[index];
//                print(foods);
//                print(foods.length);
            return GridClubs(
              img: club['img'],
              name: club['name'],
              member: club['member'],
              location: club['location'],
            );
          },
        ),
      ),
    );
  }
}
