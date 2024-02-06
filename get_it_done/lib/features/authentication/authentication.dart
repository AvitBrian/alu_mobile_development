import 'package:flutter/material.dart';
import 'package:get_it_done/features/authentication/screens/login_screen.dart';
import 'package:get_it_done/features/navigation/navigation.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});
  static bool isLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? const Navigation() : const Login();
  }
}
