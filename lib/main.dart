import 'package:flutter/material.dart';
import 'package:red_vital/screens/loginScreen.dart';
import 'package:red_vital/screens/mainscreen.dart';
import 'package:red_vital/screens/registerScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RedVital',
      theme: ThemeData(
        fontFamily: "Brand Bold",
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.idScreen,
      routes: {
        RegisterScreen.idScreen: (context) => RegisterScreen(),
        LoginScreen.idScreen: (context) => LoginScreen(),
        MainScreen.idScreen: (context) => MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
