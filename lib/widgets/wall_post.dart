import 'package:flutter/material.dart';
import 'package:peerprep2/widgets/buttons/like_button.dart';

class WallPost extends StatelessWidget {
  final String message;
  final String user;
  // final String time;
  const WallPost({
    super.key,
    required this.message,
    required this.user,
    //required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            children: [
              LikeButton(isLiked: true, onTap: () {}),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(message),
            ],
          )
        ],
      ),
    );
  }
}