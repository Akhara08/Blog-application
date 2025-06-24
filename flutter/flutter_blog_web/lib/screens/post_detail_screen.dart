import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../models/post.dart';

class PostDetailScreen extends StatelessWidget {
  final int id;

  PostDetailScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    final api = ApiService(Provider.of<AuthService>(context));
    return Scaffold(
      appBar: AppBar(title: Text('Post Details')),
      body: FutureBuilder<Post>(
        future: api.fetchPostDetail(id),
        builder: (_, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final post = snap.data!;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('by ${post.author} • ${post.createdAt}', style: TextStyle(color: Colors.grey)),
                Divider(height: 20),
                Text(post.content ?? '', style: TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}
