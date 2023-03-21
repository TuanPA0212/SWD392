import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

class QRScanScreen extends StatefulWidget {
  @override
  _QRScanScreenState createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController _controller;

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
        const storage = FlutterSecureStorage();
        final idStudent = await storage.read(key: 'idStudent');
        // Parse QR code data
        final qrData = jsonDecode(scanData.code ?? "");
        print('data qr: $qrData');
        // Send PUT request to check-in or check-out
        final eventID = qrData['event_id'];
        final status = qrData['status'];

        final now = DateTime.now();
        print('status: $status , eventID: $eventID , idStudent: $idStudent');
        // if (status == 0) {
        final responseCheckin = await http.put(
          Uri.parse(
              'https://event-project.herokuapp.com/api/event/join/$eventID/checkin'),
          body: {
            'student_id': idStudent,
            'checkin': now.toIso8601String(), // format time as string
            // "student_id": 9,
            // "checkin": "2023-03-21"
          },
        );

        // Handle response
        if (responseCheckin.statusCode == 200) {
          // Check-in or check-out success

          setState(() {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Check in Success!'),
                  content: const Text('Thanks for check in !'),
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
          });
          print('success check in $idStudent');
        } else {
          setState(() {
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
                      child: const Text('okay'),
                    ),
                  ],
                );
              },
            );
          });
          // Check-in or check-out failed
          throw Exception('Failed to check-in');
        }
        // } else {
        //   final responseCheckout = await http.put(
        //     Uri.parse(
        //         'https://event-project.herokuapp.com/api/event/join/$eventID/checkout'),
        //     body: {
        //       'student_id': idStudent,
        //       'checkout': now.toIso8601String(), // format time as string
        //     },
        //   );

        //   // Handle response
        //   if (responseCheckout.statusCode == 200) {
        //     // Check-in or check-out success
        //     setState(() {
        //       // Update UI as needed
        //     });
        //   } else {
        //     // Check-in or check-out failed
        //     throw Exception('Failed to check-out');
        //   }
        // }
      } catch (e) {
        print('not running');
        print(e);
      }
    });
  }
}
