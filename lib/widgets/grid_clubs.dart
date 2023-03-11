import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swd_project/Nav_bar/home_page.dart';

class GridClubs extends StatelessWidget {
  final String name;
  // final String img;
  int clubId;
  int campusId;
  String abbreviation;
  DateTime establishedDate;
  int totalMembers;

  GridClubs({
    Key? key,
    required this.name,
    // required this.img,
    required this.clubId,
    required this.campusId,
    required this.abbreviation,
    required this.establishedDate,
    required this.totalMembers,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: InkWell(
        // onTap: () {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (BuildContext context) {
        //         return HomePage();
        //       },
        //     ),
        //   );
        // },
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 0.0, right: 10.0),
              child: Container(
                height: MediaQuery.of(context).size.width / 3.5,
                width: MediaQuery.of(context).size.width / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    "./assets/images/fpt_logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "$name",
                    style: TextStyle(
//                    fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Text(
                        "Date of established",
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        DateFormat('dd-MM-yyyy').format(establishedDate),
                        style: TextStyle(
                          fontSize: 11.0,
                          // fontWeight: FontWeight.w900,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Number of member: ",
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "$totalMembers",
                        style: TextStyle(
                          fontSize: 11.0,
                          // fontWeight: FontWeight.w900,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
