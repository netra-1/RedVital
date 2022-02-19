import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:red_vital/model/user_model.dart';

class AcceptedBloodRequest extends StatefulWidget {
  final snap;
  const AcceptedBloodRequest({Key? key, required this.snap,}) : super(key: key);

  @override
  State<AcceptedBloodRequest> createState() => _AcceptedBloodRequestState();
}

class _AcceptedBloodRequestState extends State<AcceptedBloodRequest> {

  UserModel loggedInUser = UserModel();
  // RequestBloodModel requestBloodModelTest = RequestBloodModel();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

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

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var requestedDate =  widget.snap['requestedDate'];
    var newRequestedDate = requestedDate.split(" ");
    var acceptedDate = widget.snap['acceptedDate'];
    var newAcceptedDate = acceptedDate.split(" ");

    if(widget.snap['accept'] == "True" &&  widget.snap['donorUid'] == user?.uid ){
      return Container(
          width: screenWidth,
          height: screenHeight * 0.23,
          margin: EdgeInsets.fromLTRB(25, 15, 25, 15),
          padding: EdgeInsets.fromLTRB(15, 8, 15, 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black87),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Patient Name:  " + widget.snap['patientName'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Location:   " + widget.snap['medicalCenter'] ,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Contact Number:   " + widget.snap['contactNo'] ,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                        Text(
                          "Needed By:   " + widget.snap['neededBy'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          "Requested Date:   ${newRequestedDate[0]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          "Accepted Date:     ${newAcceptedDate[0]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),


                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 28.0,
                width: 55.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(15.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.snap['bloodType'],
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
      );} else{
      return Center(
        child: Container(
        ),
      );
    }
  }
}
