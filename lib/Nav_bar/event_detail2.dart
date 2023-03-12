import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/event2.dart';
import '../services/firebase_services.dart';

class EventDetail2 extends StatefulWidget {
  final Event2 event;

  EventDetail2({Key? key, required this.event});
  @override
  _EventDetail2State createState() => _EventDetail2State();
}

// final accessToken = AccessTokenMiddleware.getAccessToken();
// String authToken = accessToken;
// final studentId = AccessTokenMiddleware().getStudentId();

// createRegisDate() {
//   final DateTime registrationDate = DateTime.now();
//   print("regis Date: $registrationDate");
// }

class _EventDetail2State extends State<EventDetail2> {
  int? idStudent;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        idStudent = prefs.getInt('idStudent') ?? null;
      });
    });
  }

  Future<void> registerStudentForEvent(int eventId) async {
    // final Event eventId;
    final DateTime registrationDate = DateTime.now();
    print("regis Date: $registrationDate");
    final url = Uri.parse('https://event-project.herokuapp.com/api/event/join');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(<String, dynamic>{
        'event_id': eventId,
        'student_id': idStudent,
        'registration_date': registrationDate.toIso8601String(),
      }),
    );

    await Future.delayed(Duration(seconds: 2));

    if (response.statusCode == 200) {
      print('Student successfully registered for event!');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Join successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      print(
          'Failed to register student for event. Error code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Event Details",
        ),
        elevation: 0.0,
        // actions: <Widget>[
        //   Container(
        //     height: MediaQuery.of(context).size.height / 2,
        //     width: MediaQuery.of(context).size.width,
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(8.0),
        //       child: Image.asset(
        //         "assets/images/fpt_logo.png",
        //         fit: BoxFit.contain,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ListView(
          children: <Widget>[
            // SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.event.img,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              widget.event.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
            //   child: Row(),
            // ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Time: ",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    widget.event.startDate,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                // Text(
                //   "Location",
                //   style: TextStyle(
                //     fontSize: 15.0,
                //     fontWeight: FontWeight.w300,
                //   ),
                // ),
                // SizedBox(width: 10.0),
                // Text(
                //   event.location,
                //   style: TextStyle(
                //     fontSize: 14.0,
                //     fontWeight: FontWeight.w500,
                //     color: Colors.green[300],
                //   ),
                // ),
                // Image.network(
                //   'https://upload.wikimedia.org/wikipedia/vi/1/1d/Logo_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_FPT.png',
                //   // fit: BoxFit.contain,
                // ),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  "Location:",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Text(
                    widget.event.location,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                      // color: Colors.green[300],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Text(
                widget.event.description!,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        child: ElevatedButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Confirmation'),
                  content: Text('Are you sure you want to join this event?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // do something when the user confirms
                        registerStudentForEvent(widget.event.eventId);
                      },
                      child: Text('Join'),
                    ),
                  ],
                );
              },
            );
            // await FirebaseMessaging.instance.getInitialMessage();
            // createRegisDate();
            // registerStudentForEvent(widget.event.eventId);
          },
          child: Text(
            "JOIN EVENT",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          // color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
