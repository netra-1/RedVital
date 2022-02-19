import 'package:flutter/material.dart';
import 'package:red_vital/screens/bloodRequest/blood_request.dart';
import 'package:red_vital/screens/maps/hospitals.dart';
import 'package:red_vital/screens/profile/profile_screen.dart';

import 'home_page.dart';

class BottomPage extends StatefulWidget {
  var index;

  BottomPage({Key? key, required this.index}) : super(key: key);
  @override
  _BottomPageState createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  // int selectedIndex = widget.index;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 35, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOption = <Widget>[
    HomePage(),

    BloodRequest(),

    Hospitals(),

    ProfileScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0c0f14),
      body: Center(
        child: _widgetOption.elementAt(widget.index),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Color(0xff0c0f14),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 32,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bloodtype,
                size: 32,
              ),
              label: "Find Donor",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_hospital,
                size: 32,
              ),
              label: "Hospitals",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 32,
              ),
              label: "Profile",
            ),
          ],
          currentIndex: widget.index,
          unselectedItemColor: Color(0xff4e5053),
          selectedItemColor: Color(0xffd17842),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}