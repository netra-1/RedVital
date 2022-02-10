import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_password_login/screens/profile/requestContainer.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'model/user_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
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
    );
  }
}
