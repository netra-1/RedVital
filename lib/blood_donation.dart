import 'package:flutter/material.dart';

class Dmc extends StatefulWidget {

  static const String idScreen = "dmc";

  @override
  _DmcState createState() => _DmcState();
}

class _DmcState extends State<Dmc> {
  var formKey = GlobalKey<FormState>();
  var obtMarks = '';
  var percentage = '';
  var grade = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Find Donor',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: 'Type group you want..',
                      labelText: 'Blood Group',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  validator: (text) {


                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Enter your age..',
                      labelText: 'Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  validator: (text) {

                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: 'Enter your current location..',
                      labelText: 'Location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  validator: (text) {

                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: 'Expected time',
                      labelText: 'Expected time',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  validator: (text) {

                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {

                              });
                            },
                            child: Text('Clear'))),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                            },
                            child: Text('Send Request',))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
