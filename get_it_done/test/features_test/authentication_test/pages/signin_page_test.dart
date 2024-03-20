import 'package:flutter/material.dart';
import 'package:get_it_done/providers/provider.dart';
import 'package:get_it_done/features/authentication/pages/signin_page.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => AuthStateProvider(), // Example provider creation
        child: SignInForm(),
      ),
    );
  }
}