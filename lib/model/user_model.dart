class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  // String? phoneNo;
  // String? bloodType;
  String? downloadURL;

  UserModel({this.uid, this.email, this.firstName, this.secondName, this.downloadURL});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      downloadURL: map['downloadURL'],
      // phoneNo: map['phoneNo'],
      // bloodType: map['bloodType'],
    );
  }



  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      // 'phoneNo': phoneNo,
      // 'bloodType': bloodType
    };
  }
}

// class UserModelRetrive {
//   String? downloadURL;
//
//   UserModelRetrive({this.downloadURL});
//
//   // receiving data from server
//   factory UserModelRetrive.fromMap(map) {
//     return UserModelRetrive(
//         downloadURL: map['downloadURL']
//
//     );
//   }
//
//
//
//   // sending data to our server
//   Map<String, dynamic> toMap() {
//     return {
//       'downloadURL': downloadURL
//     };
//   }
// }

