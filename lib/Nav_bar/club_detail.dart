import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../model/club.dart';

class ClubDetail extends StatefulWidget {
  final Club club;
  const ClubDetail({Key? key, required this.club});

  @override
  State<ClubDetail> createState() => _ClubDetailState();
}

class _ClubDetailState extends State<ClubDetail> {
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
                    // child: Image.network(
                    //   widget.club.img,
                    //   fit: BoxFit.contain,
                    // ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              widget.club.name,
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
                    widget.club.establishedDate as String,
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
                    widget.club.abbreviation,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                      // color: Colors.green[300],
                    ),
                  ),
                )
              ],
            ),
            // SizedBox(height: 20.0),
            // Text(
            //   "Description",
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w800,
            //   ),
            //   maxLines: 2,
            // ),
            // SizedBox(height: 10.0),
            // Expanded(
            //   child: Text(
            //     widget.event.description!,
            //     style: TextStyle(
            //       fontSize: 13,
            //       fontWeight: FontWeight.w300,
            //     ),
            //   ),
            // ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
