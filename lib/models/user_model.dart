import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String username;
  String email;
  String id;
  String photoUrl;

  UserModel({
    required this.username,
    required this.email,
    required this.id,
    required this.photoUrl,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        id = json['id'],
        photoUrl = json['photoUrl'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['id'] = id;
    data['photoUrl'] = photoUrl;
    return data;
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel.fromJson(snapshot);
  }
}
