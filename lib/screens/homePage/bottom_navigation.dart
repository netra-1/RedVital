import 'package:flutter/material.dart';
import 'package:red_vital/screens/profile/profile_screen.dart';

import '../maps/blood_banks.dart';
import '../bloodRequest/blood_request.dart';
import 'home_page.dart';
import '../maps/hospitals.dart';

class BottomPage extends StatefulWidget {
  @override
  _BottomPageState createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOption = <Widget>[
    HomePage(),

    BloodBanks(),

    BloodRequest(),

    Hospital(),

    ProfileScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0c0f14),
      body: Center(
        child: _widgetOption.elementAt(_selectedIndex),
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
                size: 28,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance_rounded,
                size: 28,
              ),
              label: "BloodBank",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bloodtype,
                size: 28,
              ),
              label: "FindDonor",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_hospital,
                size: 28,
              ),
              label: "Hospitals",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 28,
              ),
              label: "Profile",
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Color(0xff4e5053),
          selectedItemColor: Colors.redAccent,
          // selectedItemColor: Color(0xffd17842),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
