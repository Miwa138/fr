import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fr/view/HomePage.dart';

class PhoneLoginPage extends StatefulWidget {
  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  String _phoneNumber = '';
  String _verificationCode = '';
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _verifyPhoneNumber() async {
    setState(() {
      _isLoading = true;
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        setState(() {
          _isLoading = false;
        });
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _isLoading = false;
        });
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _isLoading = false;
        });
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Введите код верификации'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  _verificationCode = value;
                });
              },
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  PhoneAuthCredential credential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: _verificationCode);
                  await _auth.signInWithCredential(credential);

                  setState(() {
                    _isLoading = false;
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomePage()));
                  });
                },
                child: const Text('Подтвердить'),

              ),

            ],
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  _phoneNumber = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Введите номер телефона',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _verifyPhoneNumber,
              child: const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Text('Вход'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}