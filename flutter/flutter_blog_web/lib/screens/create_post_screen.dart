import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _title = TextEditingController();
  final _content = TextEditingController();
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final api = ApiService(Provider.of<AuthService>(context));

    return Scaffold(
      appBar: AppBar(title: Text('Create Post')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _title, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: _content, decoration: InputDecoration(labelText: 'Content'), maxLines: 8),
            SizedBox(height: 20),
            _saving
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() => _saving = true);
                      final ok = await api.createPost(_title.text, _content.text);
                      setState(() => _saving = false);
                      if (ok) {
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Failed to create post')));
                      }
                    },
                    child: Text('Submit'),
                  )
          ],
        ),
      ),
    );
  }
}
