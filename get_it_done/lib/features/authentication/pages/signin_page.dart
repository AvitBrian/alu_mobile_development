import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it_done/features/navigation/screens/home_screen.dart';
import 'package:get_it_done/providers/auth_provider.dart';
import 'package:get_it_done/utils/constants.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthStateProvider>(context);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    bool isLoading = false;
    bool hasError = false;
    String error = '';

    Future<void> handleEmailAndPasswordSignIn() async {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        hasError = true;
        error = 'Please fill in all fields';
        return;
      }

      try {
        isLoading = true;
        await authProvider.signInWithEmailAndPassword(email, password);
        isLoading = false;
        handleAfterLogin(context);
      } on FirebaseAuthException catch (e) {
        isLoading = false;
        switch (e.code) {
          case 'user-not-found':
            error = 'User not found. Please check your email.';
            break;
          case 'wrong-password':
            error = 'Incorrect password. Please try again.';
            break;
          case 'invalid-email':
            error = 'Invalid email. Please try again.';
            break;
          default:
            error = 'An unexpected error occurred. Please try again.';
            break;
        }
        hasError = true;
      } catch (_) {
        isLoading = false;
        hasError = true;
        error = 'An unexpected error occurred. Please try again.';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            child: const Text(
              "Journalize",
              style: TextStyle(fontSize: 26),
            ),
          ),
          Text(
            "Welcome Back, you've been missed!",
            style: TextStyle(color: MyConstants.textColor),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: hasError ? error : "Email",
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            controller: emailController,
          ),
          const SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              hintText: hasError ? error : "Password",
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            controller: passwordController,
            obscureText: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text("Forgot Password?"),
              ),
            ],
          ),
          Stack(
            children: [
              MaterialButton(
                onPressed: handleEmailAndPasswordSignIn,
                child: const Text("Sign in"),
              ),
              if (isLoading)
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
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void handleAfterLogin(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 200)).then(
      (_) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              const HomeScreen(title: "Get it Done"),
        ),
      ),
    );
  }
}
