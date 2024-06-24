import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String username;
  String email;
  String id;
  String photoUrl;
  String school;
  // String courseOfStudy;

  UserModel({
    required this.username,
    required this.email,
    required this.id,
    required this.photoUrl,
    required this.school,
    // required this.courseOfStudy,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        id = json['id'],
        photoUrl = json['photoUrl'],
        school = json['school'];
        // courseOfStudy = json['couse of study'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['id'] = id;
    data['photoUrl'] = photoUrl;
    data['school'] = school;
    // data['course of study'] = courseOfStudy;
    return data;
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel.fromJson(snapshot);
  }
}
