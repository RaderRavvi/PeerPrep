import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey [300],
      appBar: AppBar(
        title: const Text('Profilo'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: const [
          // Immagine profilo
          /* ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage (
              width: width ?? 120,
              height: width ?? 120,
              imageUrl: firestore.collection('users').doc(Utils.currentUid()).snapshots().,
              fit: BoxFit.cover,
              placeholder: (context, url) => const LoadingWheel(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
      )
    ); */
          // email dell'utente

          //user details

          // username

          // bio

          // post dell'utente
        ],
      ),
    );
  }
}