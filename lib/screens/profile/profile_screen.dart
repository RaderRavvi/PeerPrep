import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peerprep2/utils/firebase.dart';
import 'package:peerprep2/utils/utils.dart';
import 'package:peerprep2/widgets/profile/profile_textbox.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Modifica campo
  Future<void> editField(String field) async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey [300],
      appBar: AppBar(
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profilo',
            ),
          ],
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(Utils.currentUid()).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                const SizedBox(height: 50),
                // Foto profilo
                const Icon(
                  Icons.person,
                  size: 72,
                ),
                const SizedBox(height: 10),

                // email dell'utente
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 50),

                //user details
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Le mie informazioni',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),

                // username
                ProfileTextBox(
                  text: userData['username'],
                  sectionName: 'Nome utente',
                  onPressed: () => editField('username'),
                ),

                // bio
                ProfileTextBox(
                  text: 'Empty bio',
                  sectionName: 'Bio',
                  onPressed: () => editField('username'),
                ),
                
                // post dell'utente
                //TODO post utente
              ],
            );
          } else if(snapshot.hasError) {
            return Center(
              child: Text('Errore: ${snapshot.error}'),
            );
          }

          return const Center(child: CircularProgressIndicator(),);
        }
      )
    );
  }
}