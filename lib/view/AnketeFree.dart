// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fr/firebase/auth/auth_controller.dart';

final AuthController _authController = AuthController();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final TextEditingController _controllerBrand = TextEditingController();
TextEditingController _controllerProductBrand = TextEditingController();
TextEditingController _controllerProductName = TextEditingController();

class AnketeFreeOrder extends StatefulWidget {
  const AnketeFreeOrder({Key? key}) : super(key: key);

  @override
  State<AnketeFreeOrder> createState() => _AnketeFreeOrderState();
}

class _AnketeFreeOrderState extends State<AnketeFreeOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _controllerBrand,
              decoration: const InputDecoration(
                label: Text("brand"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _controllerProductBrand,
              decoration: const InputDecoration(
                label: Text("product bran"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _controllerProductName,
              decoration: const InputDecoration(
                label: Text("product name"),
              ),
            ),
          ),
          TextButton(onPressed: () {}, child: const Text('Add photo')),
          TextButton(
              onPressed: () async {
                if (_controllerBrand.text.isNotEmpty &&
                    _controllerProductBrand.text.isNotEmpty &&
                    _controllerProductName.text.isNotEmpty) {
                  await _firestore
                      .collection('users')
                      .doc(_authController.user!.uid)
                      .collection('ankets')
                      .add({
                    'brand': _controllerBrand.text,
                    'productBrand': _controllerProductBrand.text,
                    'productName': _controllerProductName.text,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Успешно!'),
                      duration: Duration(seconds: 3)));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Заполните все поля!'),
                      duration: Duration(seconds: 3)));
                }
              },
              child: const Text(
                'Activate!',
                style: TextStyle(fontSize: 23, color: Colors.green),
              )),
        ],
      ),
    );
  }
}
