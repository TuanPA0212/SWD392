import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swd_project/Nav_bar/main_page.dart';
import 'package:swd_project/Nav_bar/profile_page.dart';

class QRScanScreen extends StatefulWidget {
  @override
  _QRScanScreenState createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController _controller;
  int? idStudent;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        idStudent = prefs.getInt('idStudent') ?? null;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await _controller.pauseCamera();
    }
    _controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: QRView(
        key: _qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.greenAccent,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    ));
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    _controller.scannedDataStream.listen((scanData) async {
      try {
        // Parse QR code data
        final qrData = jsonDecode(scanData.code ?? "");
        print('data qr: $qrData');
        // Send PUT request to check-in or check-out
        final eventID = qrData['event_id'];
        final status = qrData['status'];

        DateTime now = DateTime.now();
        final check = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

        print('date $check');
        print('status: $status , eventID: $eventID , idStudent: $idStudent ');
        final studentID = int.parse(idStudent.toString());

        (status == "0")
            ? await http
                .put(
                    Uri.parse(
                        'https://evenu.herokuapp.com/api/event/join/$eventID/checkin'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(
                      <String, dynamic>{
                        'student_id': idStudent,
                        'checkin': check, // format time as string
                      },
                    ))
                .then((responseCheckin) {
                final response = responseCheckin.statusCode;
                print('code check in $response, ');

                // Handle response
                (responseCheckin.statusCode == 200)
                    ? (setState(() {
                        _controller.pauseCamera();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Check in Success!'),
                              content: const Text('Thanks for check in !'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return const MainPage();
                                        },
                                      ),
                                    );
                                  },
                                  child: const Text('okay'),
                                ),
                              ],
                            );
                          },
                        );
                        print('success check in $idStudent');
                      }))
                    : (setState(() {
                        _controller.pauseCamera();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Check in Fail'),
                              content: const Text('Plz Check in again!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Okay'),
                                ),
                              ],
                            );
                          },
                        );
                        // Check-in or check-out failed
                        throw Exception('Failed to check-in');
                      }));
              })
            : await http
                .put(
                    Uri.parse(
                        'https://evenu.herokuapp.com/api/event/join/$eventID/checkout'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(
                      <String, dynamic>{
                        'student_id': idStudent,
                        'checkout': check, // format time as string
                      },
                    ))
                .then((responseCheckout) {
                // Handle response
                final responseCheck = responseCheckout.statusCode;
                print(responseCheck);
                (responseCheckout.statusCode == 200)
                    ? (setState(() {
                        _controller.pauseCamera();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Check out Success!'),
                              content: const Text('Thanks for check out !'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return const MainPage();
                                        },
                                      ),
                                    );
                                  },
                                  child: const Text('okay'),
                                ),
                              ],
                            );
                          },
                        );
                      }))
                    : (setState(() {
                        _controller.pauseCamera();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Check out Fail'),
                              content: const Text('Plz Check out again!'),
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
                        // Check-in or check-out failed
                        throw Exception('Failed to check-in');
                      }));
              });
      } catch (e) {
        print('not running');
        print(e);
      }
    });
  }
}
