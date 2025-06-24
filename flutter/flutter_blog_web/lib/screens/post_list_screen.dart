import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'post_detail_screen.dart';
import 'create_post_screen.dart';
import '../models/post.dart';



class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late Future<List<Post>> _futurePosts;

  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthService>(context, listen: false);
    _futurePosts = ApiService(auth).fetchPosts();
  }

  void _refreshPosts() {
    final auth = Provider.of<AuthService>(context, listen: false);
    setState(() {
      _futurePosts = ApiService(auth).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final api = ApiService(auth);

    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Posts'),
        actions: [
          if (auth.token != null)
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                auth.logout();
              },
            ),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: _futurePosts,
        builder: (_, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final posts = snap.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, i) => ListTile(
              title: Text(posts[i].title),
              subtitle: Text(posts[i].summary ?? ''),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostDetailScreen(id: posts[i].id),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: auth.token != null
          ? FloatingActionButton(
              child: Icon(Icons.create),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CreatePostScreen()),
                );
                _refreshPosts(); // ✅ Reload after returning from CreatePostScreen
              },
            )
          : null,
    );
  }
}
