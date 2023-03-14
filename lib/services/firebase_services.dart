import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
        FirebaseAuth fAuth = FirebaseAuth.instance;
        final User? firebaseUser = (await fAuth
                .signInWithCredential(authCredential)
                .catchError((msg) {}))
            .user;
        if (firebaseUser != null) {
          String token = await firebaseUser.getIdToken();
          print('Get token from firebase: $token');
          await sendTokenApi(token);
          // String accessToken = await sendTokenApi(token);
          // AccessTokenMiddleware.setAccessToken(accessToken);
          // print("device token is :");
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> sendTokenApi(String token) async {
    // print("device token is :");
    final url = 'https://event-project.herokuapp.com/api/login';
    final headers = {
      'Content-Type': 'application/json',
    };
    final storage = FlutterSecureStorage();
    String? deviceToken = await storage.read(key: 'device_token');
    print("device token is : $deviceToken");
    final body = json.encode({
      'token': token,
      'role': 'members',
      'deviceToken': deviceToken,
    });
    final response =
        await http.post(Uri.parse(url), body: body, headers: headers);
    final responseData = json.decode(response.body);
    print('responseData in login : $responseData');
    final accessToken = responseData['access_token'];
    final idStudent = responseData['data']['id'];
    print('id của sinh viên: $idStudent');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('idStudent', idStudent);

    // return accessToken;
  }

  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}

// class SaveDeviceToken extends StatefulWidget {
//   const SaveDeviceToken({super.key});

//   @override
//   State<SaveDeviceToken> createState() => _SaveDeviceTokenState();
// }

// class _SaveDeviceTokenState extends State<SaveDeviceToken> {
//    String? deviceToken;

//   @override
//   void initState() {
//     super.initState();
//     // Lấy giá trị của biến deviceToken từ storage trong initState
//     storage.read(key: 'device_token').then((value) {
//       setState(() {
//         deviceToken = value;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// class AccessTokenMiddleware {
//   static String? _accessToken;
//   // static String? _studentId;

//   static void setAccessToken(String accessToken) {
//     _accessToken = accessToken;
//   }

//   static String getAccessToken() {
//     return _accessToken!;
//   }

  // static void setStudentId(String studentId) {
  //   _studentId = studentId;
  // }

  // static String getStudentId() {
  //   return _studentId!;
  // }
// }
