// ignore_for_file: use_build_context_synchronously

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fr/firebase/auth/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fr/view/AnketeFree.dart';
import 'package:fr/view/BuyLeads.dart';
import 'package:fr/view/CustomWidgets/GetUserName.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final AuthController _authController = AuthController();
final name = _authController.user!.displayName.toString();
String UID = _authController.user!.uid.toString();
final TextEditingController _nameAlertController = TextEditingController();
var n = firebaseFirestore.collection('users').doc(auth.currentUser!.uid);
CollectionReference users = FirebaseFirestore.instance.collection('users');
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CircleAvatar(
                    radius: 43,
                    backgroundImage: NetworkImage(
                        'https://avatars.dzeninfra.ru/get-zen_doc/34175/pub_5cea2361585c2f00b5c9cb0b_5cea310a752e5b00b25b9c01/scale_1200'),
                  )),
              GetUserName(auth.currentUser!.uid),
            ],
          ),
          TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AnketeFreeOrder()));
              },
              child: const Text(
                'Создать анкету',
                style: TextStyle(fontSize: 17, color: Colors.black),
              )),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(auth.currentUser!.uid)
                  .collection("ankets")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('смешная ошбка');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Material(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  );
                }

                return Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var anketss = snapshot.data!.docs[index];
                        return Card(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Бренд: ',
                                            style: TextStyle(
                                                color: Colors.amber,
                                                fontSize: 16),
                                          ),
                                          Text('${anketss.get('brand')}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Марка: ',
                                            style: TextStyle(
                                                color: Colors.lightGreen,
                                                fontSize: 16),
                                          ),
                                          Text(
                                              '${anketss.get('productBrand')}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Модель: ',
                                            style: TextStyle(
                                                color: Colors.purple,
                                                fontSize: 16),
                                          ),
                                          Text('${anketss.get('productName')}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(onPressed: () {
                                    anketss.reference.delete();
                                  }, icon: Icon(Icons.delete, color: Colors.red,)),
                                ],
                              )),
                        );
                      }),
                );
              }),
          TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BuyLeads()));
          }, child: Text('Купить лиды')),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'landing', (route) => false);
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
            child: const Text(
              'Выйти',
              style: TextStyle(fontSize: 19, color: Colors.red),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}