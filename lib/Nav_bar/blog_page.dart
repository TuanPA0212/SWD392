import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swd_project/Nav_bar/notification_page.dart';

import '../widgets/badge.dart';

class Event {
  int? eventId;
  String? name;
  String? email;
  String? location;
  int? point;
  String? img;
  String? description;
  String? startDate;
  String? endDate;

  Event(
      {this.eventId,
      this.name,
      this.email,
      this.location,
      this.point,
      this.img,
      this.description,
      this.startDate,
      this.endDate});

  Event.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    name = json['name'];
    email = json['email'];
    location = json['location'];
    point = json['point'];
    img = json['img'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['location'] = this.location;
    data['point'] = this.point;
    data['img'] = this.img;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}

Future<List<Event>> searchEvents(String keyword) async {
  if (keyword.isEmpty) {
    [];
  }
  final response = await http.get(Uri.parse(
      'https://event-project.herokuapp.com/api/event/search?name=$keyword&status=0'));

  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    return list.map((model) => Event.fromJson(model)).toList();
  } else {
    throw Exception('Failed to search events');
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Event>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = searchEvents('Search events');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // void _onSearchSubmitted(String keyword) {
  //   setState(() {
  //     futureEvents = searchEvents(keyword);
  //   });
  // }

  void _onSearchSubmitted(String keyword) {
    if (keyword.isEmpty) {
      setState(() {
        futureEvents = Future.value([]);
      });
    } else {
      setState(() {
        futureEvents = searchEvents(keyword);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Events Page"),
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search events',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _onSearchSubmitted(_searchController.text),
                ),
              ),
              onSubmitted: _onSearchSubmitted,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Event>>(
              future: futureEvents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('No events found'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        // leading: Image.network((snapshot.data![index].img!)),
                        leading: Image.network(
                            'https://upload.wikimedia.org/wikipedia/vi/1/1d/Logo_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_FPT.png'),
                        title: Text(snapshot.data![index].name!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Location: ' +
                                (snapshot.data![index].location ?? '')),

                            // Text('Email: ' + snapshot.data![index].email!),
                            Text('Start Date: ' +
                                (snapshot.data![index].startDate ?? '')),
                            Text('End Date: ' +
                                (snapshot.data![index].endDate ?? '')),
                          ],
                        ),

                        onTap: () {
                          // DetailEvent();
                          print('Tap on listTile');
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(
                  // child: CircularProgressIndicator(),
                  child: Text('Search for events'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
