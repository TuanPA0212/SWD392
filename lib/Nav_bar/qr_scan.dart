import 'dart:convert';

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
    // _controller.scannedDataStream.listen((scanData) {
    //   setState(() {
    //     _controller = controller;
    //   });
    _controller.scannedDataStream.listen((scanData) async {
      try {
        final storage = const FlutterSecureStorage();
        final idStudent = await storage.read(key: 'idStudent');
        // Parse QR code data
        final qrData = jsonDecode(scanData.code ?? "");
        print('data qr: $qrData');
        // Send PUT request to check-in or check-out
        final eventID = qrData['event_id'];
        final status = qrData['status'];
        print('status: $status , eventID: $eventID');
        final now = DateTime.now();
        if (status == 0) {
          final responseCheckin = await http.put(
            Uri.parse(
                'https://event-project.herokuapp.com/api/event/join/$eventID/checkin'),
            body: {
              'student_id': idStudent,
              'checkin': now.toIso8601String(), // format time as string
            },
          );

          // Handle response
          if (responseCheckin.statusCode == 200) {
            // Check-in or check-out success

            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('check in success'),
                  duration: Duration(seconds: 3),
                ),
              );
            });
            print('success check in $idStudent');
          } else if (status == 1) {
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('check in fail'),
                  duration: Duration(seconds: 3),
                ),
              );
            });
            // Check-in or check-out failed
            throw Exception('Failed to check-in');
          }
        } else {
          final responseCheckout = await http.put(
            Uri.parse(
                'https://event-project.herokuapp.com/api/event/join/$eventID/checkout'),
            body: {
              'student_id': idStudent,
              'checkout': now.toIso8601String(), // format time as string
            },
          );

          // Handle response
          if (responseCheckout.statusCode == 200) {
            // Check-in or check-out success
            setState(() {
              // Update UI as needed
            });
          } else {
            // Check-in or check-out failed
            throw Exception('Failed to check-out');
          }
        }
      } catch (e) {
        // Handle exceptions
      }
    });
  }
}
