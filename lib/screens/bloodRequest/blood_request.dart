import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/user_model.dart';

class BloodRequest extends StatefulWidget {
  const BloodRequest({Key? key}) : super(key: key);

  @override
  _BloodRequestState createState() => _BloodRequestState();
}

class _BloodRequestState extends State<BloodRequest> {
  final _auth = FirebaseAuth.instance;

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
          hintText: "Patient's Name",
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
          hintText: "Required Time",
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

    //request blood button
    final requestButtonField = Material(
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: StadiumBorder(),
            minimumSize: Size(380.0, 48.0),
            side: BorderSide(width: 1, color: Colors.red),
          ),
          onPressed: () {
            requestButton();
          },
          child: Text(
            "Request",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.red, fontWeight: FontWeight.w600),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 45,),
            Text(
              "Find Donors",
              style: TextStyle(
                fontFamily: "Great Vibes",
                fontSize: 50,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(250, 51, 67, 1),
              ),
            ),
            SizedBox(height: 28,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
          ],
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

  }
  Future<void> requestButton() async {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);

    if (_formKey.currentState!.validate()) {
      User? user = _auth.currentUser;
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
      requestBloodModel.donorUid = "None";
      requestBloodModel.donorName = "None";
      requestBloodModel.donorContact = "None";
      requestBloodModel.requestedDate = date.toString();
      requestBloodModel.acceptedDate = "Null";

      try {
        await firebaseFirestore
            .collection("requesters")
            .doc(userId)
            .set(requestBloodModel.toMap());
        Fluttertoast.showToast(msg: "Request Sent to all donors");

      } catch(e){
        print("you got an error $e");
      }
    }
    getData();
  }
}
