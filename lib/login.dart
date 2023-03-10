import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swd_project/Nav_bar/main_page.dart';
import 'package:swd_project/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:swd_project/services/firebase_services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  const SizedBox(height: 170.0),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                      top: 25.0,
                    ),
                    child: Text(
                      "Welcome to event management",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    height: 200,
                    child: Image.asset("./assets/images/logo.png"),
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                      height: 50.0,
                      child: InkWell(
                        onTap: () async {
                          await FirebaseServices().signInWithGoogle();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()));
                        },
                        child: Container(
                          height: 50.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: Offset(0,
                                    3), // thay đổi độ lệch để tạo hiệu ứng đổ bóng
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/google_logo.png", // thay đổi đường dẫn đến hình ảnh Google logo
                                height: 25.0,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                "Login with Google",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ],
          )),
    );
  }
}
