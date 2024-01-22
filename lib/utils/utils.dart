import 'package:flutter/material.dart';
import 'package:peerprep2/utils/firebase.dart';

class Utils {
  static Future showErrorMessage ({
    required String errorMessage,
    required final BuildContext context,
  }) async {
    return showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          content: Text(errorMessage),
        );
      });
  }

  static String currentUid() {
    return firebaseAuth.currentUser!.uid;
  }
}