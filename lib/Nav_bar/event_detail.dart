import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swd_project/common_widget/color.dart';
import '../model/event.dart';
import '../services/firebase_services.dart';
import 'package:intl/intl.dart';

class EventDetail extends StatefulWidget {
  final Event event;

  EventDetail({Key? key, required this.event});
  @override
  _EventDetailState createState() => _EventDetailState();
}

// final accessToken = AccessTokenMiddleware.getAccessToken();
// String authToken = accessToken;

class _EventDetailState extends State<EventDetail> {
  int? idStudent;
  bool isJoined = false;
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
    final DateTime registrationDate = DateTime.now();
    print("regis Date: $registrationDate");
    final url = Uri.parse('https://event-project.herokuapp.com/api/event/join');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'event_id': eventId,
        'student_id': idStudent,
        'registration_date': registrationDate.toIso8601String(),
      }),
    );
    await Future.delayed(const Duration(seconds: 2));
    if (response.statusCode == 200) {
      print('Student successfully registered for event!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Join successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You were registered for event'),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        isJoined = true;
      });
      print(
          'Failed to register student for event. Error code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainTheme,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
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
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
              width: 10,
            ),
            Text(
              widget.event.eventName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, top: 5.0, left: 10.0),
              child: Row(
                children: <Widget>[
                  const Text(
                    "Time: ",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    DateFormat('dd-MM-yyyy').format(widget.event.startDate),
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[],
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                  width: 10,
                ),
                const Text(
                  "Location:",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    widget.event.location,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      // color: Colors.green[300],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                  width: 10,
                ),
                const Text(
                  "Point:",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    widget.event.point.toString(),
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 1, 168, 12),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0),
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  height: 10.0,
                  width: 10.0,
                ),
                Expanded(
                  child: Text(
                    widget.event.description!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
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
                  title: const Text('Confirmation'),
                  content: const Text('Are you sure you want to join this event?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // do something when the user confirms
                        registerStudentForEvent(widget.event.eventId);
                        setState(() {
                          isJoined = true;
                        });
                      },
                      child: const Text('Join'),
                    ),
                  ],
                );
              },
            );
            
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isJoined ? const Color.fromARGB(255, 67, 193, 71) : mainTheme,
          ),
          child: Text(
            isJoined ? "JOINED" : "JOIN EVENT",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
