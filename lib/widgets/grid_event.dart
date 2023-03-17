import 'package:flutter/material.dart';
import 'package:swd_project/Nav_bar/event_detail.dart';

import '../model/event.dart';
// import 'package:restaurant_ui_kit/screens/details.dart';
// import 'package:restaurant_ui_kit/util/const.dart';
// import 'package:restaurant_ui_kit/widgets/smooth_star_rating.dart';

class GridEvents extends StatelessWidget {
  final Event event;
  // final int eventId;
  // final String name;
  // final String img;

  const GridEvents({
    Key? key,
    required this.event,
    // required this.name,
    // required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              event.eventName,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
              ),
              maxLines: 2,
            ),
          ),
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3.6,
                width: MediaQuery.of(context).size.width / 2.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    // "./assets/images/fpt_logo.png",
                    event.img,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),

          // Padding(
          //   padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
          //   child: Row(
          //     children: <Widget>[
          //       SmoothStarRating(
          //         starCount: 5,
          //         color: Constants.ratingBG,
          //         allowHalfRating: true,
          //         rating: rating,
          //         size: 10.0,
          //       ),

          //       Text(
          //         " $rating ($raters Reviews)",
          //         style: TextStyle(
          //           fontSize: 11.0,
          //         ),
          //       ),

          //     ],
          //   ),
          // ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return EventDetail(event: event);
            },
          ),
        );
      },
    );
  }
}
