import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:red_vital/model/user_model.dart';

class RequestContainer extends StatefulWidget {
  final snap;
  const RequestContainer({Key? key, required this.snap,}) : super(key: key);

  @override
  State<RequestContainer> createState() => _RequestContainerState();
}

class _RequestContainerState extends State<RequestContainer> {

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

    final acceptButton = Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,0),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: StadiumBorder(),
            minimumSize: Size(310.0, 40.0),
            side: BorderSide(width: 1, color: Colors.red),
          ),
          onPressed: () async {
            DateTime now = new DateTime.now();
            DateTime date = new DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
            final _donationId = DateTime.now().millisecondsSinceEpoch.toString();
            DonorModel donorModel = DonorModel();
            donorModel.donationId = _donationId;
            donorModel.donorUid = user?.uid;
            donorModel.donorName = (loggedInUser.firstName!) + (loggedInUser.secondName)!;
            donorModel.contactNo = loggedInUser.phoneNo;
            donorModel.requestId = widget.snap['requestId'];
            donorModel.requesterUid = widget.snap['requesterUid'];
            if(widget.snap['accept'] == "False"){
              await firebaseFirestore
                  .collection("donors")
                  .doc(_donationId)
                  .set(donorModel.toMap())
                  .whenComplete(() => Fluttertoast.showToast(msg: "Accepted!!!"));
              var donorUID = user?.uid;
              var donorNAME =  (loggedInUser.firstName!) + (loggedInUser.secondName)!;
              var donorCONTACT = loggedInUser.phoneNo;

              await firebaseFirestore
                  .collection("requesters")
                  .doc(widget.snap['requestId'])
                  .update({"accept": "True", "donorUid" : "$donorUID", "donorName" : "$donorNAME",
                "donorContact" : "$donorCONTACT", "acceptedDate": date.toString() });
            } else{
              Fluttertoast.showToast(msg: "Request already accepted");
            }
          },
          child:Text(
            widget.snap['accept'] == "False"? "Accept" : "Accepted ;__;" ,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),)),
    );

    if(widget.snap['accept'] == "False" && widget.snap['requesterUid'] != user?.uid){
    return Container(
      width: screenWidth,
      height: screenHeight * 0.27,
      margin: EdgeInsets.fromLTRB(25, 0, 25, 15),
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
                        "Patient Name:   " + widget.snap['patientName'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Location:   " + widget.snap['medicalCenter'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Contact Number:   " + widget.snap['contactNo'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                      Text(
                        "Needed Time:   " + widget.snap['neededBy'],
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

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              acceptButton
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
              width: 58.0,
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
      return Container(
      );
    }
  }
}
