import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:red_vital/model/user_model.dart';
import 'image_upload.dart';

class EditProfilePic extends StatefulWidget {
  const EditProfilePic({Key? key}) : super(key: key);

  @override
  _EditProfilePicState createState() => _EditProfilePicState();
}

class _EditProfilePicState extends State<EditProfilePic> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();


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
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            // if(loggedInUserRetrive)
            child
                : loggedInUser.downloadURL == null
                ? const Center(
                child: Text('NoImg'))
                : Container(
                width: 190.0,
                height: 190.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(
                            loggedInUser.downloadURL!)
                    )
                )),

          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageUpload(
                            userId: loggedInUser.uid,
                          )));
                },
                child: SvgPicture.asset("assets/Camera_Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
