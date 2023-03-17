import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swd_project/common_widget/color.dart';
import 'package:swd_project/Nav_bar/edit_profile.dart';
import 'package:swd_project/Nav_bar/notification_page.dart';
import 'package:swd_project/widgets/badge.dart';
import 'package:swd_project/widgets/upload.dart';
import '../login.dart';
import 'package:swd_project/services/firebase_services.dart';

import 'history_page.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int? idStudent;
  String imgState = '';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        idStudent = prefs.getInt('idStudent') ?? null;
      });
    });
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        imgState = prefs.getString('imgState') ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Profile"),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                    // "${FirebaseAuth.instance.currentUser!.photoURL}"
                    "${imgState.isNotEmpty ? imgState : FirebaseAuth.instance.currentUser!.photoURL!}"),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Account Information',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            // Upload(),
            Text(
              'Name',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text("${FirebaseAuth.instance.currentUser!.displayName}"),

            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 8.0),
                      Text("${FirebaseAuth.instance.currentUser!.email}",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Address',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 8.0),
            Text("${FirebaseAuth.instance.currentUser!.email}",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                )),
            SizedBox(height: 16.0),
            Text(
              'Brithday',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 8.0),
            Text("${FirebaseAuth.instance.currentUser!.email}",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                )),
            SizedBox(height: 16.0),
            Text(
              'Phone Number',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 8.0),
            Text("${FirebaseAuth.instance.currentUser!.email}",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                )),
            SizedBox(height: 16.0),
            Divider(height: 10, color: Colors.black),
            SizedBox(height: 16.0),
            Text(
              'Settings',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            // ListTile(
            //   leading: Icon(Icons.image),
            //   title: Text('Upload Image'),
            //   onTap: () {},
            // ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile'),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                await FirebaseServices().signOut();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () async {
                // await FirebaseServices().signOut();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return HistoryPage();
                    },
                  ),
                );
              },
            ),
            Divider(),
          ],
        ),
      ),
    ));
  }
}


// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Image.network("${FirebaseAuth.instance.currentUser!.photoURL}"),
//           Text("${FirebaseAuth.instance.currentUser!.displayName}"),
//           Text("${FirebaseAuth.instance.currentUser!.email}"),
//           ElevatedButton(
//               onPressed: () async {
//                 await FirebaseServices().signOut();
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (BuildContext context) {
//                       return LoginScreen();
//                     },
//                   ),
//                 );
//               },
//               child: Text('Logout')),
//         ]),
//       ),
//     );
//   }
// }
