// search_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peerprep2/widgets/homepage/wall_post.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      searchText = _searchController.text;
    });
  }

  Future<List<QueryDocumentSnapshot>> _searchPostsAndComments() async {
    final postSnapshot = await FirebaseFirestore.instance
        .collection('User Posts')
        .orderBy('TimeStamp', descending: true)
        .get();

    List<QueryDocumentSnapshot> matchingPosts = [];

    for (var postDoc in postSnapshot.docs) {
      final message = postDoc['Message'].toString().toLowerCase();
      final postMatches = message.contains(searchText.toLowerCase());

      final commentSnapshot = await FirebaseFirestore.instance
          .collection('User Posts')
          .doc(postDoc.id)
          .collection('Comments')
          .get();

      final commentMatches = commentSnapshot.docs.any((commentDoc) {
        final commentText = commentDoc['CommentText'].toString().toLowerCase();
        return commentText.contains(searchText.toLowerCase());
      });

      if (postMatches || commentMatches) {
        matchingPosts.add(postDoc);
      }
    }

    return matchingPosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Cerca Post'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Cerca per testo...',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: searchText.isEmpty
                  ? Center(
                      child: Icon(
                        Icons.search,
                        size: 100,
                        color: Colors.grey[400],
                      ),
                    )
                  : FutureBuilder<List<QueryDocumentSnapshot>>(
                      future: _searchPostsAndComments(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Errore: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('Nessun post trovato'));
                        }

                        final posts = snapshot.data!;

                        return ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            return WallPost(
                              message: post['Message'],
                              user: post['UserEmail'],
                              postId: post.id,
                              likes: List<String>.from(post['Likes'] ?? []),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
