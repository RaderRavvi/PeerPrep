import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peerprep2/utils/firebase.dart';
import 'package:peerprep2/utils/utils.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _textController = TextEditingController();

  void postMessage() {
    // Posta qualcosa solo se c'è qualcosa nel textfield
    if(_textController.text.isNotEmpty) {
      // Aggiungi i dati a firebase
      firestore.collection('users')
      .doc(Utils.currentUid())
      .collection('posts').add({
        'UserEmail': currentUser.email,
        'Message': _textController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Scrivi qualcosa...',
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            IconButton(
              onPressed: postMessage, 
              icon: const Icon(Icons.arrow_circle_up),
            ),
          ],
        ),
      ],
    );
  }
}