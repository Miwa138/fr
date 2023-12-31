// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fr/firebase/auth/auth_controller.dart';

final AuthController _authController = AuthController();

class RegestrationUser extends StatefulWidget {
  const RegestrationUser({Key? key}) : super(key: key);

  @override
  State<RegestrationUser> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegestrationUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'phone_login_page_user');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
                ),
                child: const Text(
                  'Phone auth',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              TextButton(
                  onPressed: () async {
                    String res = await _authController.signInWithGoogle();
                    if (res == "success") {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "home_page", (route) => false);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
                  ),
                  child: const Text(
                    'Google auth',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  )),
            ],
          ),
        ));
  }
}
