
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peerprep2/services/homepage_service.dart';
import 'package:peerprep2/utils/firebase.dart';
import 'package:peerprep2/utils/utils.dart';
import 'package:peerprep2/widgets/buttons/comment_button.dart';
import 'package:peerprep2/widgets/buttons/delete_button.dart';
import 'package:peerprep2/widgets/buttons/like_button.dart';
import 'package:peerprep2/widgets/comment.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;
  const WallPost({
    super.key,
    required this.message,
    required this.user, 
    required this.postId, 
    required this.likes,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  bool isLiked = false;
  final _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef = firestore.collection('users').doc(Utils.currentUid()).collection('posts').doc(widget.postId);

    if(isLiked) {
      // Se al post viene messo like, aggiungi l'email dell'utente che ha messo like
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email]),
      });
    } else {
      // Se al post viene tolto like, rimuovi l'email dell'utente che ha messo like
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email]),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gruppo di testo (messaggio + username)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Messaggio
                  Text(widget.message),
              
                  // Utente
                  Text(
                    widget.user,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              // Pulsante per eliminare il post
              if(widget.user == currentUser.email)
              DeleteButton(
                onTap: () => HomePageService().deletePost(context, widget.postId)
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Like
              Column(
                children: [
                  LikeButton(
                    isLiked: isLiked, 
                    onTap: toggleLike,
                  ),

                  const SizedBox(height: 5),

                  // Contatore di like
                  Text(
                    widget.likes.length.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(width: 10),

              // Commenti
              Column(
                children: [
                  CommentButton( 
                    onTap: () => HomePageService().showCommentDialog(context, _commentTextController, widget.postId),
                  ),

                  const SizedBox(height: 5),

                  // Contatore di like
                  const Text(
                    '0',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Mostra i commenti sotto il post
          StreamBuilder<QuerySnapshot>(
            stream: usersRef.doc(Utils.currentUid())
                .collection('posts')
                .doc(widget.postId)
                .collection('comments')
                .orderBy('CommentTime', descending: true)
                .snapshots(), 
            builder: ((context, snapshot) {
              // Mostra caricamento se non ci sono dati
              if(!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                shrinkWrap: true, // Utile per ListView annidate
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  // Prendi il commento
                  final commentData = doc.data() as Map<String, dynamic>;
                  // returna il commento
                  return Comment(
                    text: commentData['CommentText'], 
                    user: commentData['CommentedBy'], 
                    time: HomePageService().formatDate(commentData['CommentTime']),
                  );
                }).toList(),
              );
            })
          ),
        ],
      ),
    );
  }
}