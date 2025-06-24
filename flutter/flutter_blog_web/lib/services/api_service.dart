import 'package:flutter_blog_web/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post.dart';

class ApiService {
  final AuthService auth;
  ApiService(this.auth);

  Future<List<Post>> fetchPosts() async {
    final res = await http.get(Uri.parse('http://127.0.0.1:8000/api/posts/'));
    if (res.statusCode == 200) {
      return (json.decode(res.body) as List)
          .map((e) => Post.fromJson(e))
          .toList();
    }
    throw Exception('Failed to load posts');
  }

  Future<Post> fetchPostDetail(int id) async {
    final res =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/posts/$id/'));
    if (res.statusCode == 200) {
      return Post.fromJson(json.decode(res.body));
    }
    throw Exception('Failed to load post');
  }

  Future<bool> createPost(String title, String content) async {
  final res = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/posts/create/'),  // ✅ Correct endpoint
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${auth.token}',
    },
    body: json.encode({'title': title, 'content': content}),
  );
  return res.statusCode == 201;
}

}
