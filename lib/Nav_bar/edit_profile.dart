import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swd_project/Nav_bar/notification_page.dart';
import 'package:swd_project/Nav_bar/profile_page.dart';
import 'package:swd_project/model/student.dart';
import 'package:swd_project/widgets/badge.dart';
// import 'package:swd_project/widgets/upload.dart';
import 'package:swd_project/common_widget/color.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';

class EditProfile extends StatefulWidget {
  final Student student;
  EditProfile({Key? key, required this.student});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController imgController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  bool isEdit = false;
  // static String? imagePath;
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
    final student = widget.student;
    if (student != null) {
      isEdit = true;
      // _imageFile = student.studentImg.toString();
      _address = student.address ?? '';
      _phoneNumber = student.phone ?? '';
      _birthday = DateFormat('dd-MM-yyyy').format(student.birthday);
      addressController.text = _address;
      phoneController.text = _phoneNumber;
      birthdayController.text = _birthday ?? '';
    }
  }

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
          filename: (_imageFile!.path)));
    }
    final response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Save profile success !'),
              content: const Text('Your profile has been changed !'),
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
      });
    } else {
      // handle failure
      setState(() {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Save profile fail !'),
              content: const Text('Plz choice image to save success !'),
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save profile'),
            duration: Duration(seconds: 5),
          ),
        );
      });
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
        _birthday = DateFormat('yyyy/MM/dd').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // String imagePath = _imageFile!.path;

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mainTheme,
        automaticallyImplyLeading: true,
        title: Text(
            // isEdit ? "Edit Profile" : "Create",
            "Edit Profile"),
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
                  child: Column(children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage:
                      NetworkImage(widget.student.studentImg ?? ''),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    final pickedFile = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    setState(() {
                      _imageFile =
                          pickedFile != null ? File(pickedFile.path) : null;
                    });
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Your avatar has already been changed !'),
                          duration: Duration(seconds: 5),
                        ),
                      );
                    });
                  },
                  child: Text('Change Photo'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        mainTheme), // Change the color to blue
                  ),
                ),
              ])),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  // labelStyle:
                  //     TextStyle(color: Color.fromRGBO(183, 147, 219, 24)),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Color.fromRGBO(183, 147, 219, 24)),
                  ),
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
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Color.fromRGBO(183, 147, 219, 24)),
                  ),
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
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Color.fromRGBO(183, 147, 219, 24)),
                        ),
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
                      onTap: () => _selectDate(context),
                    ),
                  ),
                  // const SizedBox(width: 16),
                  // ElevatedButton(
                  //   onPressed: () => _selectDate(context),
                  //   child: Text('Select Birthday'),
                  // ),
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
                  style: ElevatedButton.styleFrom(backgroundColor: mainTheme),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
