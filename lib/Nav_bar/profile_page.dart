import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swd_project/Nav_bar/qr_scan.dart';
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
                          return const NotificationPage();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(
                              imgState.isNotEmpty
                                  ? imgState
                                  : FirebaseAuth
                                      .instance.currentUser!.photoURL!,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            FirebaseAuth.instance.currentUser!.displayName!,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    const Text(
                      'Student Information',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    // Upload(),

                    const Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 8.0),
                    Text("${FirebaseAuth.instance.currentUser!.email}",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                        )),

                    const SizedBox(height: 16.0),
                    const Text(
                      'Address',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 8.0),
                    Text("${FirebaseAuth.instance.currentUser!.email}",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                        )),
                    const SizedBox(height: 16.0),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Birthday',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 8.0),
                              Text("22/10/2001",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[600],
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Phone Number',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 8.0),
                              Text("09999999",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[600],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Divider(height: 20, color: Colors.black),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Settings',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    // ListTile(
                    //   leading: Icon(Icons.image),
                    //   title: Text('Upload Image'),
                    //   onTap: () {},
                    // ),
                    ListTile(
                      leading: const Icon(Icons.edit,
                          color: Color.fromARGB(255, 12, 97, 166)),
                      title: const Text('Edit Profile'),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()),
                        );
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.history,
                          color: Color.fromARGB(255, 231, 155, 24)),
                      title: const Text('History'),
                      onTap: () async {
                        // await FirebaseServices().signOut();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const HistoryPage();
                            },
                          ),
                        );
                      },
                    ),

                    ListTile(
                      leading: const Icon(
                        Icons.qr_code,
                        color: Color.fromARGB(255, 34, 186, 39),
                      ),
                      title: const Text('Scan QR Code'),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QRScanScreen()),
                        );
                      },
                    ),

                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: const Text('Logout'),
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
                  ],
                ),
              ),
            )));
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
