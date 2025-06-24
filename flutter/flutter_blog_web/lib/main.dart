import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'screens/login_screen.dart';
import 'screens/post_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: MaterialApp(
        title: 'Flutter Blog Web',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Consumer<AuthService>(
          builder: (context, auth, _) =>
              auth.token == null ? LoginScreen() : PostListScreen(),
        ),
      ),
    );
  }
}
