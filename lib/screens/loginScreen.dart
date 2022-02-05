import 'package:flutter/material.dart';
import 'package:red_vital/screens/registerScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String idScreen = "login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 45.0,),
              const Image(
                image: AssetImage("images/logo.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),

              const SizedBox(height: 1.0,),
              const Text(
                "Welcome to RedVital",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,

              ),

              Padding(
                  padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    //  EmailField
                    SizedBox(height: 1.0,),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),


                  //  PasswordField
                    SizedBox(height: 1.0,),
                    TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 20.0,),
                    RaisedButton(
                      color: Colors.yellow,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: (){
                        print("Logged In");
                      },
                    ),

                  ],
                ),
              ),

              FlatButton(
                child: Text(
                    "Don't have an account? Register Here."
                ),
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, RegisterScreen.idScreen, (route) => false);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
