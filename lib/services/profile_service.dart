import 'package:flutter/material.dart';
import 'package:peerprep2/utils/firebase.dart';
import 'package:peerprep2/utils/utils.dart';

class ProfileService {

  Future<void> editField(String field, BuildContext context) async {
    String newValue = '';

    await showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Modifica $field',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        content: TextField(
          style: const TextStyle(color: Colors.white),
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Nuovo/a $field',
            hintStyle: const TextStyle(color: Colors.white),
            
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed:() => Navigator.pop(context), 
            child: const Text('Annulla', style: TextStyle(color: Colors.white),)
          ),

          TextButton(
            onPressed:() => Navigator.of(context).pop(newValue),
            child: const Text('Conferma', style: TextStyle(color: Colors.white),)
          ),
        ],
      ),
    );

    // Aggiorna su firestore
    if(newValue.trim().isNotEmpty) {
      await usersRef.doc(Utils.currentUid()).update({field: newValue});
    }
  }
}