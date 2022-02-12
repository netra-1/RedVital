import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_vital/screens/bloodRequest/acceptedBloodRequestPage.dart';
import 'package:red_vital/screens/bloodRequest/myRequestPage.dart';
import 'package:red_vital/screens/bloodRequest/requestContainer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final myRequestButton = Padding(
      padding: const EdgeInsets.fromLTRB(25,154,0,0),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: StadiumBorder(),
            minimumSize: Size(150.0, 40.0),
            side: BorderSide(width: 1, color: Colors.red),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyRequestPage()));
          },
          child: Text(
            "My Requests",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, color: Colors.red, fontWeight: FontWeight.w600),
          )),
    );
    final acceptedRequestButton = Padding(
      padding: const EdgeInsets.fromLTRB(180,154,25,0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: StadiumBorder(),
          minimumSize: Size(150.0, 40.0),
          side: BorderSide(width: 1, color: Colors.red),
        ),
        onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) =>
          AcceptedBloodRequestPage()));
        },
        child: Text(
          "Accepted Requests ",
          textAlign: TextAlign.center,
          style: TextStyle(
          fontSize: 15, color: Colors.red, fontWeight: FontWeight.w600),
        )),
    );


    return Scaffold(
        body: Center(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(85,70,0,0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "RedVital",
                      style: TextStyle(
                        fontFamily: "Majesty",
                        fontSize: 52,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(250, 51, 67, 1),
                      ),
                    ),
                  ],
                ),
              ),
              myRequestButton,
              acceptedRequestButton,
              Padding(
                padding: const EdgeInsets.fromLTRB(25,228,0,100),
                child: Text("Blood Requests",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                      ),
                    ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,264,0,0),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('requesters').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    return ListView.builder(itemCount: snapshot.data!.docs.length,itemBuilder: (context, index) =>RequestContainer(
                      snap: snapshot.data!.docs[index].data(),

                    ));
                  },


                ),
              ),
            ],
          ),
        )
    );
  }
}