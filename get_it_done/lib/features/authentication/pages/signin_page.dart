import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it_done/features/navigation/screens/home_screen.dart';
import 'package:get_it_done/providers/provider.dart';
import 'package:get_it_done/utils/app_settings.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool hasError = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthStateProvider>(context);

    Future<void> handleEmailAndPasswordSignIn() async {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        setState(() {
          error = 'Email and Password Required!';
          hasError = true;
        });
      }

      try {
        setState(() {
          isLoading = true;
          hasError = false; // Reset error state
        });

        // Proceed with sign-in
        await authProvider.signInWithEmailAndPassword(email, password);
        print(authProvider.currentUser);
        if (authProvider.currentUser != null) {
          handleAfterLogin(context);
        } else {
          setState(() {
            isLoading = false;
            hasError = true;
            error = 'wrong password or email';
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
          hasError = true;
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
        });
      } catch (_) {
        setState(() {
          isLoading = false;
          hasError = true;
          error = 'An unexpected error occurred. Please try again.';
        });
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 70.0, vertical: AppSettings.screenHeight(context) * .3),
        child: Column(
          children: [
            Text(
              "GET IT DONE!",
              style: TextStyle(fontSize: 26, color: AppSettings.secondaryColor),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: AppSettings.secondaryColor.withOpacity(.1),
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.person_2_outlined)),
              controller: emailController,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: AppSettings.secondaryColor.withOpacity(.1),
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.lock_open_rounded)),
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
            Visibility(
              visible: hasError,
              child: SizedBox(
                height: 50,
                child: Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  color: Colors.orangeAccent,
                  height: 45,
                  width: AppSettings.screenWidth(context) * 0.8,
                  child: MaterialButton(
                    onPressed: handleEmailAndPasswordSignIn,
                    color: AppSettings.secondaryColor,
                    child: const Text("Sign in"),
                  ),
                ),
                if (isLoading)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppSettings.secondaryColor,
                    ),
                    height: 76,
                    width: AppSettings.screenWidth(context),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orangeAccent,
                        strokeWidth: 5,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
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
