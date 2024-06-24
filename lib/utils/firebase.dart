import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;

// Collection refs
// CollectionReference usersRef = firestore.collection('User Posts');

// Utente attuale
User currentUser = FirebaseAuth.instance.currentUser!;

Stream<DocumentSnapshot<Map<String, dynamic>>> stream = firestore.collection('User Posts').doc(currentUser.email).snapshots();
