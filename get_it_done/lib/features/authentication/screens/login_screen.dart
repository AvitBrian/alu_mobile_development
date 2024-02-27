import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Text(
          "Get It Done!",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }

  _inputField(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.person)),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                filled: true,
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Login",
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  _forgotPassword(context) {
    return TextButton(
        onPressed: () {},
        child: Text(
          "Forgot password?",
          style: const TextStyle(fontSize: 8),
        ));
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Dont have an account? ",
          style: const TextStyle(fontSize: 8),
        ),
        TextButton(onPressed: () {}, child: Text("Sign Up"))
      ],
    );
  }
}
