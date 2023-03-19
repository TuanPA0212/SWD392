import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:swd_project/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swd_project/common_widget/color.dart';

class Upload extends StatefulWidget {
  // const UploadScreen({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    // final Storage storage = Storage();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
        Center(
            child: ElevatedButton(
          onPressed: () async {
            final results = await FilePicker.platform.pickFiles(
              allowMultiple: false,
              type: FileType.custom,
              allowedExtensions: ['png', 'jpg'],
            );
            if (results == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No file selected')));
              return null;
            }
            final path = results.files.single.path!;
            final fileName = results.files.single.name;

            print(path);
            print(fileName);
            //Định nghĩa Url gửi file
            String url = 'https://event-project.herokuapp.com/images';
            //tạo request
            http.MultipartRequest request =
                http.MultipartRequest('POST', Uri.parse(url));
            //đưa file vào form
            var file = await http.MultipartFile.fromPath('file', path);
            request.files.add(file);
            //gửi đi
            final response = await request.send();

            // Listen for response and get result
            final responseBodyBytes = await response.stream.bytesToString();
            // final responseBodyString = String.fromCharCodes(responseBodyBytes);
            // print(responseBodyString);
            print('data: ' + responseBodyBytes);
            final responseData = json.decode(responseBodyBytes);
            final imgState = responseData['data'];
            print(imgState);
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('imgState', imgState);
            // return imgstate;
            // storage.uploadFile(path, fileName).then((value) => print('Done'));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(mainTheme),
          ),
          child: Text('Upload file'),
        ))
      ]),
    );
  }
}
