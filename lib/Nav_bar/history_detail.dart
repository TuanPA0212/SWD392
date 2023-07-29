import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:swd_project/model/history.dart';

import '../common_widget/color.dart';

class HistoryDetail extends StatefulWidget {
  final History history;
  const HistoryDetail({Key? key, required this.history});

  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
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
                      widget.history.img,
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
              widget.history.name,
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
                    DateFormat('dd-MM-yyyy').format(widget.history.startDate),
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
                    widget.history.location,
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
                  "Price:",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    widget.history.price.toString(),
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
                    widget.history.description!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.history.img,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
