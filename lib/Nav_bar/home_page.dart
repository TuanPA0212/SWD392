import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:swd_project/Nav_bar/notification_page.dart';
import 'package:swd_project/login.dart';
import 'package:swd_project/services/firebase_services.dart';
import 'package:swd_project/widgets/badge.dart';
import 'package:swd_project/widgets/grid_event.dart';
import 'package:http/http.dart' as http;
import '../model/event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Event> eventList = [];

  List imagesList = [
    {"id": 1, "image_path": "assets/images/fpt_logo.png"},
    {"id": 2, "image_path": 'assets/images/fpt_logo.png'},
  ];

  List<Map> events = [
    {"img": "assets/images/fpt_logo.png", "name": "Event 1"},
    {"img": "assets/images/fpt_logo.png", "name": "Event 2"},
    {"img": "assets/images/fpt_logo.png", "name": "Event 3"},
    {"img": "assets/images/fpt_logo.png", "name": "Event 4"},
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home Page"),
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
      body: ListView(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  // print(currentIndex);
                },
                child: CarouselSlider(
                  items: imagesList
                      .map(
                        (item) => Image.asset(
                          item['image_path'],
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      )
                      .toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: true,
                    aspectRatio: 1.0,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          getAllEventGridView()
        ],
      ),
    );
  }

  Widget getAllEventGridView() {
    return FutureBuilder<List<Event>>(
      future: fetchAllEvents(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Event> events = snapshot.data!;
          return Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: events.length,
              itemBuilder: (BuildContext context, int index) {
                final event = events[index];
                return GridEvents(
                  event: event,
                  // eventId: events[index].eventId,
                  // name: events[index].clubName,
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

  Future<List<Event>> fetchAllEvents() async {
    final response = await http.get(
        Uri.parse("https://event-project.herokuapp.com/api/event/?status=1"));

    final responseData = json.decode(response.body) as List;
    // print('responseData: $responseData');
    if (response.statusCode == 200) {
      return responseData.map((e) => Event.fromJson(e)).toList();
    } else {
      throw Exception("Fail to fetch");
    }
  }
}
