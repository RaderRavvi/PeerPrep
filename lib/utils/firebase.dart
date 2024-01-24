import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:peerprep2/utils/utils.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;

// Collection refs
CollectionReference usersRef = firestore.collection('users');

// Utente attuale
User currentUser = FirebaseAuth.instance.currentUser!;

Stream<DocumentSnapshot<Map<String, dynamic>>> stream = firestore.collection('users').doc(Utils.currentUid()).snapshots();
