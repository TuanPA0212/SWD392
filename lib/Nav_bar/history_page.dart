import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:swd_project/common_widget/color.dart';
import 'package:swd_project/model/history.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<History> historyList = [];
  List historyItem = [
    {
      "img": "assets/images/fpt_logo.png",
      "name": "camus tour",
      "startDate": "10/2/2023",
      "endDate": "10/3/2023"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainTheme,
        title: Text('History'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return getHistoryView();
        },
      ),
    );
  }

  FutureBuilder<List<History>> getHistoryView() {
    return FutureBuilder<List<History>>(
      future: fetchHistory(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<History> histories = snapshot.data!;
          return ListView.builder(
            itemCount: histories.length,
            itemBuilder: (BuildContext context, int index) {
              // final item = historyItem[index];
              return Card(
                child: Row(
                  children: [
                    // Cột bên trái với hình ảnh
                    Container(
                      width: 100,
                      height: 100, // Điều chỉnh độ rộng của cột hình ảnh
                      child: Image.network(
                        // historyItem[0]["img"],
                        histories[index].img,
                        fit: BoxFit.contain,
                      ),
                    ),
                    // Cột bên phải với thông tin
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                histories[index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Row(
                                children: [
                                  Text("Start Date: "),
                                  Text(DateFormat('dd-MM-yyyy')
                                      .format(histories[index].startDate))
                                ],
                              ),
                              Row(
                                children: [
                                  Text("End Date: "),
                                  Text(DateFormat('dd-MM-yyyy')
                                      .format(histories[index].endDate)),
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<List<History>> fetchHistory() async {
    final storage = new FlutterSecureStorage();
    final idStudent = int.tryParse(await storage.read(key: 'idStudent') ?? '');
    final response = await http.get(Uri.parse(
        "https://evenu.herokuapp.com/api/event/join/student/$idStudent"));

    final responseData = json.decode(response.body) as List;
    print('responseData: $responseData');
    if (response.statusCode == 200) {
      return responseData.map((e) => History.fromJson(e)).toList();
    } else {
      throw Exception("Fail to fetch");
    }
  }
}
