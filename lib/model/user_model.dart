class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? phoneNo;
  String? bloodType;
  String? downloadURL;
  String? gender;
  String? age;

  UserModel({this.uid, this.email, this.firstName, this.secondName, this.downloadURL, this.phoneNo, this.bloodType, this.gender, this.age});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      downloadURL: map['downloadURL'],
      phoneNo: map['phoneNo'],
      bloodType: map['bloodType'],
      gender: map['gender'],
      age: map['age'],
    );
  }



  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'phoneNo': phoneNo,
      'bloodType': bloodType,
      'gender': gender,
      'age': age,
    };
  }
}


class RequestBloodModel {
  String? requesterUid;
  String? patientName;
  String? contactNo;
  String? bloodType;
  String? neededBy;
  String? medicalCenter;
  String? requestId;
  String? accept;
  String? donorUid;
  String? donorName;
  String? donorContact;
  String? requestedDate;
  String? acceptedDate;
  // String? message;

  RequestBloodModel({this.requesterUid, this.patientName, this.contactNo,
    this.bloodType, this.neededBy, this.medicalCenter,
    this.requestId, this.accept, this.donorUid, this.donorName,
    this.donorContact, this.requestedDate, this.acceptedDate});

  // receiving data from server
  factory RequestBloodModel.fromMap(map) {
    return RequestBloodModel(
      requesterUid: map['requesterUid'],
      patientName: map['patientName'],
      contactNo: map['contactNo'],
      bloodType: map['bloodType'],
      neededBy: map['neededBy'],
      medicalCenter: map['medicalCenter'],
      requestId: map['requestId'],
      accept: map['accept'],
      donorUid: map['donorUid'],
      donorName: map['donorName'],
      donorContact: map['donorContact'],
      requestedDate: map['requestedDate'],
      acceptedDate: map['acceptedDate'],
      // message: map['message'],
    );
  }



  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'requesterUid': requesterUid,
      'patientName': patientName,
      'contactNo': contactNo,
      'bloodType': bloodType,
      'neededBy': neededBy,
      'medicalCenter': medicalCenter,
      'requestId':requestId,
      'accept': accept,
      'donorUid': donorUid,
      'donorName': donorName,
      'donorContact': donorContact,
      'requestedDate': requestedDate,
      'acceptedDate': acceptedDate,
      // 'message': message
    };
  }
}

class DonorModel {
  String? donorUid;
  String? donationId;
  String? donorName;
  String? contactNo;
  String? requestId;
  String? requesterUid;
  // String? message;

  DonorModel({this.donorUid, this.donationId, this.donorName, this.contactNo, this.requestId, this.requesterUid});

  // receiving data from server
  factory DonorModel.fromMap(map) {
    return DonorModel(
      donorUid: map['donorUid'],
      donationId: map['donationId'],
      donorName: map['donorName'],
      contactNo: map['contactNo'],
      requestId: map['requestId'],
      requesterUid: map['requesterUid'],

      // message: map['message'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'donorUid': donorUid,
      'donationId': donationId,
      'donorName': donorName,
      'contactNo': contactNo,
      'requestId': requestId,
      'requesterUid': requesterUid,

      // 'message': message
    };
  }
}
