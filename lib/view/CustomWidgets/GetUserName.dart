import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
CollectionReference users = FirebaseFirestore.instance.collection('users');
class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("${data['firstname']}", style: TextStyle(fontSize: 21.3),);
        }

        return Text("loading");
      },
    );
  }
}

CollectionReference sellers = FirebaseFirestore.instance.collection('sellers');
class GetSellerName extends StatelessWidget {
  final String documentId;

  GetSellerName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('sellers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("${data['firstname']}", style: TextStyle(fontSize: 21.3),);
        }

        return Text("loading");
      },
    );
  }
}