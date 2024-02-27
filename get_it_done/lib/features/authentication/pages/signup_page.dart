import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it_done/features/navigation/screens/home_screen.dart';
import 'package:get_it_done/providers/auth_provider.dart';
import 'package:get_it_done/utils/constants.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthStateProvider>(context);
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();
    bool _isLoading = false;
    bool _hasError = false;
    String _error = '';

    Future<void> handleSignUp() async {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final username = _usernameController.text.trim();

      if (email.isEmpty || password.isEmpty || username.isEmpty) {
        _hasError = true;
        _error = 'Fill in all fields';
        return;
      }

      try {
        _isLoading = true;
        await authProvider.signUp(email, password, username);
        final currentUser = authProvider.currentUser;

        if (currentUser != null) {
          await FirebaseFirestore.instance.collection("users").add({
            "name": username,
            "email": currentUser.email,
            "uid": currentUser.uid,
            "photoUrl": null,
          });
          authProvider.setAuthState(currentUser);
          _isLoading = false;
          handleAfterSignUp(context);
        }
      } on FirebaseAuthException catch (e) {
        _hasError = true;
        switch (e.code) {
          case 'user-not-found':
            _error = 'User not found. Please check your email.';
            break;
          case 'wrong-password':
            _error = 'Incorrect password. Please try again.';
            break;
          case 'invalid-email':
            _error = 'Invalid email. Please try again.';
            break;
          default:
            _error = 'An unexpected error occurred. Please try again.';
            break;
        }
      } catch (e) {
        _hasError = true;
        _error = 'An unexpected error occurred. Please try again.';
      } finally {
        _isLoading = false;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: MyConstants.screenHeight(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16.0),
              const Text(
                "Let's Sign You Up!",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: _hasError ? _error : 'Username',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
                controller: _usernameController,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: _hasError ? _error : 'Email',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
                controller: _emailController,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: _hasError ? _error : "Password",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
                controller: _passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 8),
              MaterialButton(
                onPressed: handleSignUp,
                child: Text("Register"),
              ),
              if (_isLoading)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyConstants.secondaryColor,
                  ),
                  height: 76,
                  width: MyConstants.screenWidth(context),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                      strokeWidth: 5,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void handleAfterSignUp(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 200)).then(
      (_) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(
            title: "Get It Done",
          ),
        ),
      ),
    );
  }
}
