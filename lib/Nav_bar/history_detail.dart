import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:swd_project/model/history.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import 'dart:typed_data';

import '../common_widget/color.dart';

class HistoryDetail extends StatefulWidget {
  final History history;
  const HistoryDetail({Key? key, required this.history});

  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  Future<Uint8List> _generateQrCode() async {
    String base64Data = widget.history.qrcode;
    List<int> bytes = base64.decode(base64Data);
    return Uint8List.fromList(bytes);
  }

  Color bgColor = Color(0xFF2D3436);
  @override
  Widget build(BuildContext context) {
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
      backgroundColor: bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.history.payment == 1)
            Center(
              child: QrImageView(
                data: widget.history.qrcode,
                version: QrVersions.auto,
                size: 300.0,
                backgroundColor: Colors.white,
              ),
            )
          else
            Center(
              child: Text(
                "Please  check out first",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
