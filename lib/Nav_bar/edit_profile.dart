import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swd_project/Nav_bar/notification_page.dart';
import 'package:swd_project/model/student.dart';
import 'package:swd_project/widgets/badge.dart';
// import 'package:swd_project/widgets/upload.dart';
import 'package:swd_project/common_widget/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EditProfile extends StatefulWidget {
  final Student student;
  EditProfile({Key? key, required this.student});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  late String _address;
  late String _phoneNumber;
  String? _birthday;
  int? idStudent;
  String imgState = '';
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        idStudent = prefs.getInt('idStudent');
        print('idStudent in ediut profile: $idStudent');
      });
    });
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        imgState = prefs.getString('imgState') ?? '';
      });
    });
  }

  // Future<void> _saveProfile() async {
  //   final url =
  //       Uri.parse('https://event-project.herokuapp.com/api/student/$idStudent');
  //   final response = await http.put(
  //     url,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, dynamic>{
  //       'address': _address,
  //       'phone': _phoneNumber,
  //       'birthday': _birthday,
  //     }),
  //   );
  //   if (response.statusCode == 200) {
  //     // handle success
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Profile saved'),
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   } else {
  //     // handle failure
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Failed to save profile'),
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   }
  // }

  Future<void> _saveProfile() async {
    final url =
        Uri.parse('https://event-project.herokuapp.com/api/student/$idStudent');
    final request = http.MultipartRequest('PUT', url)
      ..fields['address'] = _address
      ..fields['phone'] = _phoneNumber
      ..fields['birthday'] = _birthday!;
    if (_imageFile != null) {
      request.files.add(http.MultipartFile('file',
          _imageFile!.readAsBytes().asStream(), _imageFile!.lengthSync(),
          filename: basename(_imageFile!.path)));
    }
    final response = await request.send();
    if (response.statusCode == 200) {
      // handle success
      // ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      //   const SnackBar(
      //     content: Text('Profile saved'),
      //     duration: Duration(seconds: 3),
      //   ),
      // );
      print("uplode succes");
    } else {
      // handle failure
      // ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      //   const SnackBar(
      //     content: Text('Failed to save profile'),
      //     duration: Duration(seconds: 3),
      //   ),
      // );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _birthday = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mainTheme,
        automaticallyImplyLeading: true,
        title: const Text("Edit Profile"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications,
              size: 22.0,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return NotificationPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 50.0,
                  // backgroundImage: NetworkImage(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final pickedFile =
                      await ImagePicker().getImage(source: ImageSource.gallery);
                  setState(() {
                    _imageFile =
                        pickedFile != null ? File(pickedFile.path) : null;
                  });
                },
                child: Text('Change Photo'),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phoneNumber = value!;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Birthday',
                        border: OutlineInputBorder(),
                      ),
                      controller: TextEditingController(text: _birthday),
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your birthday';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _birthday = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Select Birthday'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _saveProfile();
                    }
                  },
                  child: const Text('Save Profile'),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
