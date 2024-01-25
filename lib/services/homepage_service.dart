import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peerprep2/utils/firebase.dart';
import 'package:peerprep2/utils/utils.dart';

class HomePageService {

  // Aggiungi un commento
  void addComment(String commentText, String postId) {
    usersRef.doc(Utils.currentUid()).collection('posts').doc(postId).collection('comments').add({
      'CommentText' : commentText,
      'CommentedBy' : currentUser.email,
      'CommentTime' : Timestamp.now(),
    });
  }
    // Mostra una finestra di dialogo per aggiungere un commento
  void showCommentDialog (BuildContext context, TextEditingController controller, String postId) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text('Aggiungi un commento'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Scrivi un commento',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.clear();
            },
            child: const Text('Annulla'),
          ),

          TextButton(
            onPressed: () {
              addComment(controller.text, postId);
              Navigator.pop(context);
              controller.clear();
            }, 
            child: const Text('Pubblica'),
          ),
        ],
      ),
    );
  }

  // Formatta un timestamp in una stringa
  String formatDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();

    String year = dateTime.year.toString();

    String month = dateTime.month.toString();

    String day = dateTime.day.toString();

    String formattedData = '$day/$month/$year';

    return formattedData;
  }
}
