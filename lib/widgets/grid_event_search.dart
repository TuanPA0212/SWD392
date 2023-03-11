// import 'package:flutter/material.dart';
// import 'package:swd_project/Nav_bar/event_detail.dart';

// import '../model/event.dart';
// // import 'package:restaurant_ui_kit/screens/details.dart';
// // import 'package:restaurant_ui_kit/util/const.dart';
// // import 'package:restaurant_ui_kit/widgets/smooth_star_rating.dart';

// class GridEventsSearch extends StatelessWidget {
//   final Event event;
//   // final int eventId;
//   // final String name;
//   // final String img;

//   const GridEventsSearch({
//     Key? key,
//     required this.event,
//     // required this.name,
//     // required this.img,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       // leading: Image.network((snapshot.data![index].img!)),
//       leading: Image.network(
//           'https://upload.wikimedia.org/wikipedia/vi/1/1d/Logo_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_FPT.png'),
//       title: Text(event.name!),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text('Location: ' + (event.location ?? '')),

//           // Text('Email: ' + snapshot.data![index].email!),
//           Text('Start Date: ' + (event.startDate ?? '')),
//           Text('End Date: ' + (event.endDate ?? '')),
//         ],
//       ),

//       onTap: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (BuildContext context) {
//               return EventDetail(event: event[index]);
//             },
//           ),
//         );
//       },
//     );
//   }
// }
