import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:red_vital/model/user_model.dart';
import 'myAccount.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  // string for displaying the error Message
  String? errorMessage;
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


  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final phoneNoEditingController = new TextEditingController();
  final ageEditingController = new TextEditingController();
  final genderEditingController = new TextEditingController();
  final bloodTypeEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // first name field
    firstNameEditingController.text = "${loggedInUser.firstName}";
    secondNameEditingController.text = "${loggedInUser.secondName}";
    phoneNoEditingController.text = "${loggedInUser.phoneNo}";
    ageEditingController.text = "${loggedInUser.age}";
    genderEditingController.text = "${loggedInUser.gender}";
    bloodTypeEditingController.text = "${loggedInUser.bloodType}";
    //first name field
    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //second name field
    final secondNameField = TextFormField(
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Second Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          secondNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Second Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // phone number
    final phoneNoField = TextFormField(
        autofocus: false,
        controller: phoneNoEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Phone no cannot be empty");
          }
          if (!RegExp("( *?[0-9] *?){10}")
              .hasMatch(value)) {
            return ("Please Enter a valid number");
          }
          return null;
        },
        onSaved: (value) {
          phoneNoEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // gender
    final ageField = TextFormField(
        autofocus: false,
        controller: ageEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Age cannot be empty");
          }
          return null;
        },
        onSaved: (value) {
          ageEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Age",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // age
    final genderField = TextFormField(
        autofocus: false,
        controller: genderEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter your gender");
          }
          return null;
        },
        onSaved: (value) {
          genderEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "gender",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final bloodTypeField = TextFormField(
        autofocus: false,
        controller: bloodTypeEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Blood type cannot be empty");
          }
          return null;
        },
        onSaved: (value) {
          bloodTypeEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Blood Type",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm button
    final confirmButton = Material(
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: StadiumBorder(),
            minimumSize: Size(380.0, 50.0),
            side: BorderSide(width: 1, color: Colors.red),
          ),
          onPressed: () {
            confirm();
          },
          child: Text(
            "Confirm",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.red, fontWeight: FontWeight.w600),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            // passing this to our root
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             MyAccount()));

            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(23, 0, 23, 23),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontFamily: "Great Vibes",
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(250, 51, 67, 1),
                    ),
                  ),
                  SizedBox(height: 30),
                  firstNameField,
                  SizedBox(height: 20),
                  secondNameField,
                  SizedBox(height: 20),
                  phoneNoField,
                  SizedBox(height: 20),
                  genderField,
                  SizedBox(height: 20),
                  ageField,
                  SizedBox(height: 20),
                  bloodTypeField,
                  SizedBox(height: 20),
                  confirmButton,
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void confirm() async {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;

      UserModel userModel = UserModel();

      // writing all the values
      userModel.email = user!.email;
      userModel.uid = user.uid;
      userModel.firstName = firstNameEditingController.text;
      userModel.secondName = secondNameEditingController.text;
      userModel.phoneNo = phoneNoEditingController.text;
      userModel.bloodType = bloodTypeEditingController.text;
      userModel.gender = genderEditingController.text;
      userModel.age = ageEditingController.text;

      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .update(userModel.toMap()).whenComplete(
              () => Fluttertoast.showToast(msg: "Edited successfully!!"))
          .then((value) => Navigator.of(context).pop());

      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => MyAccount()),
              (route) => false);
    }
  }
}