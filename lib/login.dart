import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swd_project/Nav_bar/home_page.dart';
import 'package:swd_project/Nav_bar/main_page.dart';
import 'package:swd_project/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:swd_project/services/firebase_services.dart';
import 'dart:ui';
import 'common_widget/app_text.dart';
import 'common_widget/app_button.dart';

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
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/event.png"),
          fit: BoxFit.contain,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(),
              SizedBox(
                height: 20,
              ),
              welcomeTextWidget(),
              SizedBox(
                height: 10,
              ),
              sloganText(),
              SizedBox(
                height: 40,
              ),
              getButton(context),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget welcomeTextWidget() {
    return Column(
      children: [
        AppText(
          text: "Welcome",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 8, 38, 12),
        ),
        AppText(
          text: "to our event",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 8, 38, 12),
        ),
      ],
    );
  }

  Widget sloganText() {
    return AppText(
      text: "Join event now !!!",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(255, 8, 32, 12).withOpacity(0.7),
    );
  }

  Widget getButton(BuildContext context) {
    return AppButton(
      label: "Login with Google ",
      fontWeight: FontWeight.w600,
      padding: EdgeInsets.symmetric(vertical: 25),
      onPressed: () async {
        // onGetStartedClicked(context);
        await FirebaseServices().signInWithGoogle();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ));
      },
    );
  }

  void onGetStartedClicked(BuildContext context) {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (context) => HomePage(),
    ));
  }

  // return Scaffold(
  //   backgroundColor: Theme.of(context).accentColor,
  //   body: Padding(
  //       padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
  //       child: Column(
  //         children: [
  //           ListView(
  //             shrinkWrap: true,
  //             children: <Widget>[
  //               const SizedBox(height: 170.0),
  //               Container(
  //                 alignment: Alignment.center,
  //                 margin: const EdgeInsets.only(
  //                   top: 25.0,
  //                 ),
  //                 child: Text(
  //                   "Welcome to event management",
  //                   style: TextStyle(
  //                     fontSize: 22.0,
  //                     fontWeight: FontWeight.w700,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 30.0),
  //               Container(
  //                 height: 200,
  //                 child: Image.asset("./assets/images/logo.png"),
  //               ),
  //               const SizedBox(height: 30.0),
  //               Container(
  //                   height: 50.0,
  //                   child: InkWell(
  //                     onTap: () async {
  //                       await FirebaseServices().signInWithGoogle();
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => const MainPage()));
  //                     },
  //                     child: Container(
  //                       height: 50.0,
  //                       width: double.infinity,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10.0),
  //                         color: Colors.white,
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Colors.grey.withOpacity(0.5),
  //                             spreadRadius: 1,
  //                             blurRadius: 7,
  //                             offset: Offset(0,
  //                                 3), // thay đổi độ lệch để tạo hiệu ứng đổ bóng
  //                           ),
  //                         ],
  //                       ),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Image.asset(
  //                             "assets/images/google_logo.png", // thay đổi đường dẫn đến hình ảnh Google logo
  //                             height: 25.0,
  //                           ),
  //                           SizedBox(width: 10.0),
  //                           Text(
  //                             "Login with Google",
  //                             style: TextStyle(
  //                               fontSize: 16.0,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.grey[800],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   )),
  //             ],
  //           ),
  //         ],
  //       )),
  // );
}
