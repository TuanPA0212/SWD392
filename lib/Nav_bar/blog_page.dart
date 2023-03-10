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
  Null? description;
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

<<<<<<< HEAD
class _BlogPageState extends State<BlogPage> {
  // List<Map> events = [
  //   {"img": "assets/images/macbook-air.png", "name": "Event 1"},
  //   {"img": "assets/images/14-promax.png", "name": "Event 2"},
  //   {
  //     "img": "assets/images/macbook-air.png",
  //     "name": "Event 1 going aroung vietnam from coc sg"
  //   },
  //   {"img": "assets/images/14-promax.png", "name": "Event 2"},
  // ];

  // List<Map> comments = [
  //   {"img": "assets/images/tuan.png", "name": "Tin", "comment": "Nice event"},
  //   {"img": "assets/images/tuan.png", "name": "Thuan", "comment": "Nice event"},
  //   {"img": "assets/images/tuan.png", "name": "Tuan", "comment": "Nice event"},
  //   {"img": "assets/images/tuan.png", "name": "Khoa", "comment": "Nice event"},
  // ];

  // bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // return Scaffold(
    //   appBar: AppBar(
    //     automaticallyImplyLeading: false,
    //     // leading: IconButton(
    //     //   icon: Icon(
    //     //     Icons.keyboard_backspace,
    //     //   ),
    //     //   onPressed: () => Navigator.pop(context),
    //     // ),
    //     centerTitle: true,
    //     title: Text(
    //       "Blog Page",
    //     ),
    //     elevation: 0.0,
    //     actions: <Widget>[
    //       IconButton(
    //         icon: IconBadge(
    //           icon: Icons.notifications,
    //           size: 22.0,
    //         ),
    //         onPressed: () {
    //           Navigator.of(context).push(
    //             MaterialPageRoute(
    //               builder: (BuildContext context) {
    //                 return NotificationPage();
    //               },
    //             ),
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    //   body: Padding(
    //     padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
    //     child: ListView(
    //       children: <Widget>[
    //         SizedBox(height: 10.0),
    //         Stack(
    //           children: <Widget>[
    //             Container(
    //               height: MediaQuery.of(context).size.height / 3.2,
    //               width: MediaQuery.of(context).size.width,
    //               child: ClipRRect(
    //                 borderRadius: BorderRadius.circular(8.0),
    //                 child: Image.asset(
    //                   "${events[1]['img']}",
    //                   fit: BoxFit.contain,
    //                 ),
    //               ),
    //             ),
    //             Positioned(
    //               right: -10.0,
    //               bottom: 3.0,
    //               child: RawMaterialButton(
    //                 onPressed: () {},
    //                 fillColor: Colors.white,
    //                 shape: CircleBorder(),
    //                 elevation: 4.0,
    //                 child: Padding(
    //                   padding: EdgeInsets.all(5),
    //                   child: Icon(
    //                     isFav ? Icons.favorite : Icons.favorite_border,
    //                     color: Colors.red,
    //                     size: 17,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         SizedBox(height: 10.0),
    //         Text(
    //           "${events[1]['name']}",
    //           style: TextStyle(
    //             fontSize: 20,
    //             fontWeight: FontWeight.w800,
    //           ),
    //           maxLines: 2,
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
    //           child: Row(
    //             children: <Widget>[
    //               Text(
    //                 "20 Pieces",
    //                 style: TextStyle(
    //                   fontSize: 11.0,
    //                   fontWeight: FontWeight.w300,
    //                 ),
    //               ),
    //               SizedBox(width: 10.0),
    //               Text(
    //                 r"$90",
    //                 style: TextStyle(
    //                   fontSize: 14.0,
    //                   fontWeight: FontWeight.w900,
    //                   color: Theme.of(context).accentColor,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         SizedBox(height: 20.0),
    //         Text(
    //           "Product Description",
    //           style: TextStyle(
    //             fontSize: 18,
    //             fontWeight: FontWeight.w800,
    //           ),
    //           maxLines: 2,
    //         ),
    //         SizedBox(height: 10.0),
    //         Text(
    //           "Nulla quis lorem ut libero malesuada feugiat. Lorem ipsum dolor "
    //           "sit amet, consectetur adipiscing elit. Curabitur aliquet quam "
    //           "id dui posuere blandit. Pellentesque in ipsum id orci porta "
    //           "dapibus. Vestibulum ante ipsum primis in faucibus orci luctus "
    //           "et ultrices posuere cubilia Curae; Donec velit neque, auctor "
    //           "sit amet aliquam vel, ullamcorper sit amet ligula. Donec"
    //           " rutrum congue leo eget malesuada. Vivamus magna justo,"
    //           " lacinia eget consectetur sed, convallis at tellus."
    //           " Vivamus suscipit tortor eget felis porttitor volutpat."
    //           " Donec rutrum congue leo eget malesuada."
    //           " Pellentesque in ipsum id orci porta dapibus.",
    //           style: TextStyle(
    //             fontSize: 13,
    //             fontWeight: FontWeight.w300,
    //           ),
    //         ),
    //         SizedBox(height: 20.0),
    //         Text(
    //           "Reviews",
    //           style: TextStyle(
    //             fontSize: 18,
    //             fontWeight: FontWeight.w800,
    //           ),
    //           maxLines: 2,
    //         ),
    //         SizedBox(height: 20.0),
    //         ListView.builder(
    //           shrinkWrap: true,
    //           primary: false,
    //           physics: NeverScrollableScrollPhysics(),
    //           itemCount: comments == null ? 0 : comments.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             Map comment = comments[index];
    //             return ListTile(
    //               leading: CircleAvatar(
    //                 radius: 25.0,
    //                 backgroundImage: AssetImage(
    //                   "${comment['img']}",
    //                 ),
    //               ),
    //               title: Text("${comment['name']}"),
    //               subtitle: Column(
    //                 children: <Widget>[
    //                   Row(
    //                     children: <Widget>[
    //                       SizedBox(width: 6.0),
    //                       Text(
    //                         "February 14, 2020",
    //                         style: TextStyle(
    //                           fontSize: 12,
    //                           fontWeight: FontWeight.w300,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   SizedBox(height: 7.0),
    //                   Text(
    //                     "${comment["comment"]}",
    //                   ),
    //                 ],
    //               ),
    //             );
    //           },
    //         ),
    //         SizedBox(height: 10.0),
    //       ],
    //     ),
    //   ),
    // );
=======
Future<List<Event>> searchEvents(String keyword) async {
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
    futureEvents = searchEvents('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String keyword) {
    setState(() {
      futureEvents = searchEvents(keyword);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Search Events'),
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Events Page"),
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
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.network(
                            'https://upload.wikimedia.org/wikipedia/vi/1/1d/Logo_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_FPT.png'),
                        title: Text('Name: ' + snapshot.data![index].name!),
                        // subtitle: Text(snapshot.data![index].location!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                'Location: ' + snapshot.data![index].location!),
                            // Text(snapshot.data![index].startDate!),
                            Text('Email: ' + snapshot.data![index].email!),
                          ],
                        ),
                        onTap: () {
                          print('Tap on listTile');
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
>>>>>>> d0515c94ccb62e5adb0a366926a83098ed504b86
  }
}

// import 'package:flutter/material.dart';
// import 'package:swd_project/Nav_bar/event_detail.dart';
// import 'package:swd_project/Nav_bar/notification_page.dart';

// import '../widgets/badge.dart';
// // import 'package:restaurant_ui_kit/screens/notifications.dart';
// // import 'package:restaurant_ui_kit/util/comments.dart';
// // import 'package:restaurant_ui_kit/util/const.dart';
// // import 'package:restaurant_ui_kit/util/foods.dart';
// // import 'package:restaurant_ui_kit/widgets/badge.dart';
// // import 'package:restaurant_ui_kit/widgets/smooth_star_rating.dart';

// class BlogPage extends StatefulWidget {
//   @override
//   _BlogPageState createState() => _BlogPageState();
// }

// class _BlogPageState extends State<BlogPage> {
//   List<Map> events = [
//     {"img": "assets/images/macbook-air.png", "name": "Event 1"},
//     {"img": "assets/images/14-promax.png", "name": "Event 2"},
//     {
//       "img": "assets/images/macbook-air.png",
//       "name": "Event 1 going aroung vietnam from coc sg"
//     },
//     {"img": "assets/images/14-promax.png", "name": "Event 2"},
//   ];

//   List<Map> comments = [
//     {"img": "assets/images/tuan.png", "name": "Tin", "comment": "Nice event"},
//     {"img": "assets/images/tuan.png", "name": "Thuan", "comment": "Nice event"},
//     {"img": "assets/images/tuan.png", "name": "Tuan", "comment": "Nice event"},
//     {"img": "assets/images/tuan.png", "name": "Khoa", "comment": "Nice event"},
//   ];

//   bool isFav = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         // leading: IconButton(
//         //   icon: Icon(
//         //     Icons.keyboard_backspace,
//         //   ),
//         //   onPressed: () => Navigator.pop(context),
//         // ),
//         centerTitle: true,
//         title: Text(
//           "Blog Page",
//         ),
//         elevation: 0.0,
//         actions: <Widget>[
//           IconButton(
//             icon: IconBadge(
//               icon: Icons.notifications,
//               size: 22.0,
//             ),
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (BuildContext context) {
//                     return NotificationPage();
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
//         child: ListView(
//           children: <Widget>[
//             SizedBox(height: 10.0),
//             Stack(
//               children: <Widget>[
//                 Container(
//                   height: MediaQuery.of(context).size.height / 3.2,
//                   width: MediaQuery.of(context).size.width,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8.0),
//                     child: Image.asset(
//                       "${events[1]['img']}",
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: -10.0,
//                   bottom: 3.0,
//                   child: RawMaterialButton(
//                     onPressed: () {},
//                     fillColor: Colors.white,
//                     shape: CircleBorder(),
//                     elevation: 4.0,
//                     child: Padding(
//                       padding: EdgeInsets.all(5),
//                       child: Icon(
//                         isFav ? Icons.favorite : Icons.favorite_border,
//                         color: Colors.red,
//                         size: 17,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10.0),
//             Text(
//               "${events[1]['name']}",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w800,
//               ),
//               maxLines: 2,
//             ),
//             // Padding(
//             //   padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
//             //   child: Row(
//             //     children: <Widget>[
//             //       SmoothStarRating(
//             //         starCount: 5,
//             //         color: Constants.ratingBG,
//             //         allowHalfRating: true,
//             //         rating: 5.0,
//             //         size: 10.0,
//             //       ),
//             //       SizedBox(width: 10.0),
//             //       Text(
//             //         "5.0 (23 Reviews)",
//             //         style: TextStyle(
//             //           fontSize: 11.0,
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             Padding(
//               padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
//               child: Row(
//                 children: <Widget>[
//                   Text(
//                     "20 Pieces",
//                     style: TextStyle(
//                       fontSize: 11.0,
//                       fontWeight: FontWeight.w300,
//                     ),
//                   ),
//                   SizedBox(width: 10.0),
//                   Text(
//                     r"$90",
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.w900,
//                       color: Theme.of(context).accentColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               "Product Description",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w800,
//               ),
//               maxLines: 2,
//             ),
//             SizedBox(height: 10.0),
//             Text(
//               "Nulla quis lorem ut libero malesuada feugiat. Lorem ipsum dolor "
//               "sit amet, consectetur adipiscing elit. Curabitur aliquet quam "
//               "id dui posuere blandit. Pellentesque in ipsum id orci porta "
//               "dapibus. Vestibulum ante ipsum primis in faucibus orci luctus "
//               "et ultrices posuere cubilia Curae; Donec velit neque, auctor "
//               "sit amet aliquam vel, ullamcorper sit amet ligula. Donec"
//               " rutrum congue leo eget malesuada. Vivamus magna justo,"
//               " lacinia eget consectetur sed, convallis at tellus."
//               " Vivamus suscipit tortor eget felis porttitor volutpat."
//               " Donec rutrum congue leo eget malesuada."
//               " Pellentesque in ipsum id orci porta dapibus.",
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               "Reviews",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w800,
//               ),
//               maxLines: 2,
//             ),
//             SizedBox(height: 20.0),
//             ListView.builder(
//               shrinkWrap: true,
//               primary: false,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: comments == null ? 0 : comments.length,
//               itemBuilder: (BuildContext context, int index) {
//                 Map comment = comments[index];
//                 return ListTile(
//                   leading: CircleAvatar(
//                     radius: 25.0,
//                     backgroundImage: AssetImage(
//                       "${comment['img']}",
//                     ),
//                   ),
//                   title: Text("${comment['name']}"),
//                   subtitle: Column(
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           // SmoothStarRating(
//                           //   starCount: 5,
//                           //   color: Constants.ratingBG,
//                           //   allowHalfRating: true,
//                           //   rating: 5.0,
//                           //   size: 12.0,
//                           // ),
//                           SizedBox(width: 6.0),
//                           Text(
//                             "February 14, 2020",
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w300,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 7.0),
//                       Text(
//                         "${comment["comment"]}",
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 10.0),
//           ],
//         ),
//       ),
//       // bottomNavigationBar: Container(
//       //   height: 50.0,
//       //   child: ElevatedButton(
//       //     child: Text(
//       //       "ADD TO CART",
//       //       style: TextStyle(
//       //         color: Colors.white,
//       //       ),
//       //     ),
//       //     // color: Theme.of(context).accentColor,
//       //     onPressed: () {},
//       //   ),
//       // ),
//     );
//   }
// }
