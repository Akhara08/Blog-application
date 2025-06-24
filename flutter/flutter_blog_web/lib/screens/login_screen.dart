import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _user = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: _user, decoration: InputDecoration(labelText: 'Username')),
          TextField(controller: _pass, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
          SizedBox(height: 20),
          _loading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    setState(() => _loading = true);
                    final ok = await auth.login(_user.text, _pass.text);
                    setState(() => _loading = false);
                    if (!ok) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login failed')));
                    }
                  },
                  child: Text('Log In'),
                ),
        ]),
      ),
    );
  }
}
