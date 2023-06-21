import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fr/view/AnketeFree.dart';
import 'package:fr/view/MainPages/ListFreeOrders.dart';
import 'package:fr/view/MainPages/ListSellers.dart';
import 'package:fr/view/Profile.dart';
import 'package:fr/view/ProfileSeller.dart';
CollectionReference users = FirebaseFirestore.instance.collection('users');
var currentPageIndex = 0;

List listScreens = [
  const ListSellers(),
  const ListFreeOrders(),
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AMID'),
        titleTextStyle: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          color: Colors.black
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.chat)),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
          }, icon: const Icon(Icons.person)),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AnketeFreeOrder()));
          }, icon: const Icon(Icons.add)),
        ],
      ),
        body: const ListSellers(),

    );
  }
}
