import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peerprep2/screens/page_core.dart';
import 'package:peerprep2/services/user_service.dart';
import 'package:peerprep2/utils/constants.dart';
import 'package:peerprep2/utils/firebase.dart';
import 'package:peerprep2/utils/utils.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
  static Future logInUser({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future signUserIn({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future signUp (
      BuildContext context,
      bool isLoading, 
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController usernameController,
      TextEditingController confirmPasswordController,
      String school,
      Stri
    ) async {
      if(passwordConfirmed(passwordController, confirmPasswordController)) {
        isLoading = false;
        try {
          await AuthService.signUserIn(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          ).then((value) {
            UserService.addUserDetails(
              email: emailController.text.trim(), 
              username: usernameController.text.trim(), 
              id: FirebaseAuth.instance.currentUser!.uid, 
              photoUrl: Constants.userImageDefault,
              school: school,
            );
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const PageCore(),
            ));
          }
        );
      } on FirebaseAuthException catch (e) {
        // ignore: use_build_context_synchronously
        Utils.showErrorMessage(errorMessage: e.message.toString(), context: context);
      } finally {
        isLoading = false;
      }
    }
  }

  bool passwordConfirmed(TextEditingController passwordController, TextEditingController confirmPasswordController) {
    if(passwordController.text.trim() == confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  List<String> getData(String collectionName) {
    List<String> list = [];

    firestore.collection("schools").get().then((value) {
       for (var item in value.docs) {
          list.add(item.get('name').toString());
       }
    });

    print(list.first);

    return list;
  }
}