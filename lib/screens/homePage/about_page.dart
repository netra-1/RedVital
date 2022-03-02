import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 30, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(108,0,0,0),
                  child: Text("About Us",
                    style: TextStyle(
                      fontFamily: "Great Vibes",
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("           Welcome to RedVital. \nA blood donation app developed by team 'Scavangers' This is all About us As we are still Students. ",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
