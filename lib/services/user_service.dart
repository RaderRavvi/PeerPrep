import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peerprep2/models/user_model.dart';
import 'package:peerprep2/utils/constants.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('users');

class UserService {
  static Future updateProfile({required UserModel user}) async {
    final documentReferencer = _collection.doc(user.id);
    return await documentReferencer.set(user.toJson());
  } 

  static Future addUserDetails({
    required email,
    required username,
    required id,
    required photoUrl,
    required school,
    // required courseOfStudy,
  }) async {
    final user = UserModel(
        username: username.toString(),
        email: email.toString(),
        id: id,
        photoUrl: Constants.userImageDefault,
        school: school,
        // courseOfStudy: courseOfStudy,
    );
    await _collection.doc(user.id).set(user.toJson());
  }

  static Future getUser(String userId) async {
    final user = await _collection.doc(userId).get();
    return UserModel.fromJson(user.data() as Map<String, dynamic>);
  }
}