import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_password_login/model/user_model.dart';
import 'package:email_password_login/screens/home_screen.dart';
import 'package:email_password_login/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BloodRequest extends StatefulWidget {
  const BloodRequest({Key? key}) : super(key: key);

  @override
  _BloodRequestState createState() => _BloodRequestState();
}

class _BloodRequestState extends State<BloodRequest> {
  final _auth = FirebaseAuth.instance;
  // final firebaseDatabase = FirebaseDatabase.instance.ref();


  // string for displaying the error Message
  String? errorMessage;


  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final patientNameEditingController = new TextEditingController();
  final contactNoEditingController = new TextEditingController();
  final bloodTypeEditingController = new TextEditingController();
  final neededByEditingController = new TextEditingController();
  final medicalCenterEditingController = new TextEditingController();
  final messageEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    //first name field
    final patientNameField = TextFormField(
        autofocus: false,
        controller: patientNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Patient's name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          patientNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Patient Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //Contact number field
    final contactNoField = TextFormField(
        autofocus: false,
        controller: contactNoEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Contact number cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          contactNoEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Contact Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //bloodType field
    final bloodTypeField = TextFormField(
        autofocus: false,
        controller: bloodTypeEditingController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Needed BloodType");
          }
          return null;
        },
        onSaved: (value) {
          bloodTypeEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Needed BloodType",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //neededBy field
    final neededByField = TextFormField(
        autofocus: false,
        controller: neededByEditingController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter A Date");
          }
          return null;
        },
        onSaved: (value) {
          neededByEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Needed BloodType Required Time",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //medicalCenter field
    final medicalCenterField = TextFormField(
        autofocus: false,
        controller: medicalCenterEditingController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter The Location Of The Medical Center");
          }
          return null;
        },
        onSaved: (value) {
          medicalCenterEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Medical Center's Location",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));


    // //medicalCenter field
    // final medicalCenter = CupertinoTextField(
    //     autofocus: false,
    //     controller: medicalCenterEditingController,
    //     keyboardType: TextInputType.text,
    //     onSubmitted: (value) {
    //       medicalCenterEditingController.text = value!;
    //     },
    //     textInputAction: TextInputAction.next,
    //     maxLines: 3,
    //     placeholder: "Enter a message (Optional)..."
    // );


    //signup button
    final requestButtonField = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            requestButton();
          },
          child: Text(
            "Request",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
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
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 45),
                    patientNameField,
                    SizedBox(height: 20),
                    contactNoField,
                    SizedBox(height: 20),
                    bloodTypeField,
                    SizedBox(height: 20),
                    neededByField,
                    SizedBox(height: 20),
                    medicalCenterField,
                    SizedBox(height: 20),
                    requestButtonField,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('requesters');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    for(var item in allData){
      final retrieve = RequestBloodModel.fromMap(item);
      // print(singledata);
      print(retrieve.medicalCenter);
      print("ok");
    }
    // final singledata = allData[0];
    // final retrieve = RequestBloodModel.fromMap(singledata);
    // print(singledata);
    // print(retrieve.medicalCenter);
    // print("ok");
  }
  Future<void> requestButton() async {
    if (_formKey.currentState!.validate()) {
      // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;
      // final user_uid = user!.uid;
      // final firebaseUser = firebaseDatabase.child("Users");
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      RequestBloodModel requestBloodModel = RequestBloodModel();
      final userId = DateTime.now().millisecondsSinceEpoch.toString();

      // writing all the values
      requestBloodModel.requestId = userId;
      requestBloodModel.requesterUid = user?.uid;
      requestBloodModel.patientName = patientNameEditingController.text;
      requestBloodModel.contactNo = contactNoEditingController.text;
      requestBloodModel.bloodType = bloodTypeEditingController.text;
      requestBloodModel.neededBy = neededByEditingController.text;
      requestBloodModel.medicalCenter = medicalCenterEditingController.text;
      requestBloodModel.accept = "False";


      try {
        await firebaseFirestore
            .collection("requesters")
            .doc(userId)
            .set(requestBloodModel.toMap());
        Fluttertoast.showToast(msg: "Request Sent to all donors");

         // firebaseUser
         //    .set({
         //      'name': 'Phisher',
         //      'address': 'barbarian'
         //    })
         //    .then((_) => Fluttertoast.showToast(msg: "Requested Successfully"));
      } catch(e){
        print("you got an error $e");
      }

      // final FirebaseDatabase database = FirebaseDatabase.instance;
      // DatabaseReference ref = database.ref("server/saving-data/fireblog");
      //
      // DatabaseReference usersRef = ref.child("users").child("requester");
      // usersRef.
      // await firebaseFirestore
      //     .collection("users")
      //     .doc(user.uid)
      //     .set(userModel.toMap());
      // Fluttertoast.showToast(msg: "Requested Successfully!!");

      // Navigator.pushAndRemoveUntil(
      //     (context),
      //     MaterialPageRoute(builder: (context) => LoginScreen()),
      //         (route) => false);
      }
      getData();
    }
  }
