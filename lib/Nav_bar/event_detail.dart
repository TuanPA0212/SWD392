import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:swd_project/common_widget/color.dart';
import '../model/event.dart';
import '../model/history.dart';
import '../services/firebase_services.dart';
import 'package:intl/intl.dart';
import '../model/cartItem.dart';

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
  bool addedToCart = false;

  // fetch History
  List<History> historyList = [];
  Future<List<History>> fetchHistory() async {
    final storage = new FlutterSecureStorage();
    final idStudent = int.tryParse(await storage.read(key: 'idStudent') ?? '');
    final response = await http.get(Uri.parse(
        "https://evenu.herokuapp.com/api/event/join/student/$idStudent"));

    final responseData = json.decode(response.body) as List;
    print('history event id: $responseData');
    if (response.statusCode == 200) {
      return responseData.map((e) => History.fromJson(e)).toList();
    } else {
      throw Exception("Fail to fetch");
    }
  }

  // Trả về true nếu event có trong danh sách history
  bool isEventPurchased() {
    final int eventId = widget.event.eventId;
    return historyList.any((history) => history.eventId == eventId);
  }

  Future<bool> isEventInCart(int eventId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? cartItemsJson = prefs.getStringList('cartItems');
    if (cartItemsJson != null) {
      final List<EventCartItem> cartItems = cartItemsJson
          .map((json) => EventCartItem.fromJson(jsonDecode(json)))
          .toList();
      return cartItems.any((item) => item.eventId == eventId);
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        idStudent = prefs.getInt('idStudent') ?? null;
        isEventAlreadyInCart().then((alreadyInCart) {
          setState(() {
            addedToCart = alreadyInCart;
          });
        });
      });
    });
    fetchHistory().then((items) {
      setState(() {
        historyList = items;
      });
    });
  }

  void addToCart() async {
    final int eventId = widget.event.eventId;
    final bool isEventAdded = await isEventInCart(eventId);

    if (isEventAdded) {
      setState(() {
        addedToCart = true;
      });
    } else {
      final EventCartItem cartItem = EventCartItem(
        eventId: eventId,
        eventName: widget.event.eventName,
        eventImage: widget.event.img,
        // eventPoint: widget.event.point,
        eventPrice: widget.event.price,
      );

      // Convert the cart item to JSON
      final cartItemJson = cartItem.toJson();

      // Lưu thông tin sự kiện vào giỏ hàng ở local
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> cartItems = prefs.getStringList('cartItems') ?? [];
      cartItems.add(json.encode(cartItemJson));
      prefs.setStringList('cartItems', cartItems);
      print('cart: $cartItems');
      setState(() {
        addedToCart = true;
      });
    }
  }

  // check có trong cart hay chưa
  Future<bool> isEventAlreadyInCart() async {
    final int eventId = widget.event.eventId;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? cartItemsJson = prefs.getStringList('cartItems');
    if (cartItemsJson != null) {
      final List<EventCartItem> cartItems = cartItemsJson
          .map((json) => EventCartItem.fromJson(jsonDecode(json)))
          .toList();
      return cartItems.any((item) => item.eventId == eventId);
    }
    return false;
  }

  Future<void> registerStudentForEvent(int eventId) async {
    final DateTime registrationDate = DateTime.now();
    print("regis Date: $registrationDate");
    final url = Uri.parse('https://evenu.herokuapp.com/api/event/join');
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
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Student successfully registered for event!'),
            content: const Text('Thanks for registered!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('okay'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You were registered for event'),
          duration: Duration(seconds: 2),
        ),
      );
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('You were registered for event'),
            content: const Text('Thanks for registered!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('okay'),
              ),
            ],
          );
        },
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
    bool purchased = isEventPurchased();
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
                  "Price:",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    widget.event.price.toString(),
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
            onPressed: purchased
                ? null
                : addedToCart
                    ? null
                    : addToCart,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isJoined ? const Color.fromARGB(255, 67, 193, 71) : mainTheme,
            ),
            child: Text(
              purchased
                  ? "Already Purchased" // Đã mua vé
                  : addedToCart
                      ? "Already in Cart" // Đã thêm vào giỏ hàng
                      : "Add to Cart",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
