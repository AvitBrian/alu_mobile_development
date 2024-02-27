import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it_done/features/authentication/pages/signin_page.dart';
import 'package:get_it_done/features/authentication/pages/signup_page.dart';
import 'package:get_it_done/providers/provider.dart';
import 'package:get_it_done/utils/app_settings.dart';
import 'package:provider/provider.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});
  static bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppSettings.backgroundColor,
      systemNavigationBarColor: AppSettings.backgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    final authStateProvider = Provider.of<AuthStateProvider>(context);

    return Scaffold(
      backgroundColor: AppSettings.backgroundColor,
      body: SafeArea(
        child: SizedBox(
          height: AppSettings.screenHeight(context),
          width: AppSettings.screenWidth(context),
          child: Column(children: [
            Expanded(
                flex: 10,
                child: SizedBox(
                    width: AppSettings.screenWidth(context),
                    child: SingleChildScrollView(
                      child: authStateProvider.signedState
                          ? const SignInForm()
                          : const SignUpForm(),
                    ))),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                width: AppSettings.screenWidth(context),
                child: authStateProvider.signedState
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Not a Member?",
                            style: TextStyle(color: AppSettings.textColor),
                          ),
                          TextButton(
                            onPressed: authStateProvider.toggleSigned,
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: const Text("Register"),
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already a member?",
                            style: TextStyle(color: AppSettings.textColor),
                          ),
                          TextButton(
                            onPressed: authStateProvider.toggleSigned,
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: const Text("Log in!"),
                          )
                        ],
                      ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
