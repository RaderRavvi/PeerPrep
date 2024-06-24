import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peerprep2/utils/firebase.dart';

class HomePageService {

  // Aggiungi un commento
  void addComment(String commentText, String postId) {
    FirebaseFirestore.instance.collection('User Posts').doc(postId).collection('Comments').add({
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

  // cancella un post
  void deletePost(BuildContext context, String postId) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text('Cancella il post'),
        content: const Text('Sei sicuro di voler eliminare il post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('Annulla'),
          ),
          TextButton(
            onPressed: () async {
              // Cancella prima tutti i commenti di un post
              final commentDocs = await FirebaseFirestore.instance
                  .collection('User Posts')
                  .doc(postId)
                  .collection('Comments')
                  .get();

              for(var doc in commentDocs.docs)  {
                await FirebaseFirestore.instance
                  .collection('User Posts')
                  .doc(postId)
                  .collection('Comments')
                  .doc(doc.id)
                  .delete();
              }

              // Cancella il post
              FirebaseFirestore.instance
                  .collection('User Posts')
                  .doc(postId)
                  .delete()
                  .then((value) => print('post cancellato'))
                  .catchError((error) => print('Impossibile cancellare il post: $error'));

              if (context.mounted) Navigator.of(context).pop();
            }, 
            child: const Text('Elimina'),
          ),
        ],
      )
    );
  }
}
