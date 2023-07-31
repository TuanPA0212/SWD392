import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swd_project/Nav_bar/home_page.dart';
import 'package:swd_project/Nav_bar/main_page.dart';
import 'package:http/http.dart' as http;
import '../common_widget/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cartItem.dart';

class CheckoutScreen extends StatefulWidget {
  final double total;
  final List<int> eventIds;
  CheckoutScreen({required this.total, required this.eventIds});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int? idStudent;

  // send api
  Future<void> checkOut(List<int> eventIds) async {
    final DateTime registrationDate = DateTime.now();
    final url = Uri.parse('https://evenu.herokuapp.com/api/event/join');
    final storage = new FlutterSecureStorage();
    final idStudent = int.tryParse(await storage.read(key: 'idStudent') ?? '');
    print('student id: ' + idStudent.toString());
    print('regis date: ' + registrationDate.toString());
    print('event id : ' + widget.eventIds.toString());
    try {
      // Gửi yêu cầu POST với dữ liệu JSON
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'event_id': widget.eventIds,
          'student_id': idStudent,
          'registration_date': registrationDate.toIso8601String(),
        }),
      );
      // print('response: ${response.statusCode}');
      // if (response.statusCode == 200) {
      //   print('API request success!');
      //   print('Response: ${response.body}');
      // } else {
      //   print('API request failed with status code: ${response.statusCode}');
      // }
    } catch (error) {
      print('API request error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainTheme,
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Thông tin chuyển khoản',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Số tài khoản:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('0123456789'),
                    SizedBox(height: 8.0),
                    Text(
                      'Ngân hàng:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Ngân hàng ABC'),
                    SizedBox(height: 8.0),
                    Text(
                      'Chủ tài khoản:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Nguyễn Văn A'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Số tiền cần thanh toán',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tổng cộng:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${widget.total}',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF27AE60)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(183, 147, 219, 1),
                ),
              ),
              onPressed: () async {
                await checkOut(widget.eventIds);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                );
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
              },
              child: Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
