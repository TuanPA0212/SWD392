import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swd_project/Nav_bar/notification_page.dart';
import 'package:swd_project/common_widget/color.dart';

import '../model/cartItem.dart';
import '../widgets/badge.dart';
import '../model/event2.dart';
import 'event_detail.dart';
import 'event_detail2.dart';
import 'package:intl/intl.dart';

Future<List<Event2>> searchEvents(String keyword) async {
  if (keyword.isEmpty) {
    [];
  }
  final response = await http.get(Uri.parse(
      'https://evenu.herokuapp.com/api/event/search?name=$keyword&status=1'));
  // print("device token is :");

  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    return list.map((model) => Event2.fromJson(model)).toList();
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
  late Future<List<Event2>> futureEvents;
  List<EventCartItem> cartItems = [];

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
        backgroundColor: mainTheme,
        automaticallyImplyLeading: false,
        title: const Text("Events Page"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications,
              size: 22.0,
              itemCount: cartItems.length,
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
            child: FutureBuilder<List<Event2>>(
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
                      List<Event2> events = snapshot.data!;
                      final event = events[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        child: ListTile(
                          leading: Image.network(event.img),
                          title: Text(snapshot.data![index].name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Location: ' + (event.location)),
                              Text('Start Date: ' +
                                  DateFormat('dd-MM-yyyy')
                                      .format(event.startDate)),
                              Text('End Date: ' +
                                  DateFormat('dd-MM-yyyy')
                                      .format(event.endDate)),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return EventDetail2(event: event);
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(
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
