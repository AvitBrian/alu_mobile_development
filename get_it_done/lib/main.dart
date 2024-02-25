import 'package:flutter/material.dart';

import 'features/authentication/authentication.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Authentication(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}
