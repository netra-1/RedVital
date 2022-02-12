import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:red_vital/model/user_model.dart';
import 'package:red_vital/screens/homePage/about_page.dart';

import '../../loginRegister/login_screen.dart';
import '../../loginRegister/change_password.dart';
import 'divider.dart';
import 'myAccount.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: BasicTheme.theme(context),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 40),
            ProfilePic(),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
                      style: TextStyle(
                        color: Color.fromRGBO(25, 25, 25, 0.8),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      )),
                  SizedBox(
                    height: 7,
                  ),
                  Text("${loggedInUser.email}",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      )),
                ],
              ),

            ),
            SizedBox(height: 5),
            ProfileMenu(
              text: "My Account",
              icon: "assets/User.svg",
              press: (){Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyAccount()));},
            ),
            Divider(),
            ProfileMenu(
              text: "Change Password",
              icon: "assets/Settings.svg",
              press: (){Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePassword()));},
            ),
            Divider(),
            ProfileMenu(
              text: "About Us",
              icon: "assets/about.svg",
              press: () {Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AboutPage()));},
            ),
            Divider(),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/Log_out.svg",
              press: () {logout(context);},
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}