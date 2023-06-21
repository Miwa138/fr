import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fr/firebase/auth/auth_controller.dart';
import 'package:fr/view/Profile.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
TextEditingController _messageController = TextEditingController();

class ChatingScreen extends StatefulWidget {
  final chatid;

  const ChatingScreen({Key? key, required this.chatid}) : super(key: key);

  @override
  State<ChatingScreen> createState() => _ChatingScreenState();
}

class _ChatingScreenState extends State<ChatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(auth.currentUser!.uid)
                .collection(widget.chatid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('ошибка код: 202');
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

              return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var messages = snapshot.data!.docs[index];
                        return

                          Padding(padding: EdgeInsets.only(left: 13),child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                messages.get('message'),
                                style: TextStyle(color: Colors.black),
                              ),

                              Text(
                                messages.get('user'),
                                style: TextStyle(color: Colors.amberAccent),

                              ),
                            ],
                          ),
                          IconButton(onPressed: () {
                            messages.reference.delete();
                          }, icon: Icon(Icons.delete, color: Colors.red,)),
                          ],
                        ));
                      }));
            }),
        TextField(
          controller: _messageController,
          decoration: InputDecoration(
              suffixIcon: IconButton(
            onPressed: () async {
              String? value = _messageController.text;
              if (value.isNotEmpty) {
                await firebaseFirestore
                    .collection('users')
                    .doc(auth.currentUser!.uid)
                    .collection(widget.chatid)
                    .add({
                  'message': _messageController.text,
                  'user': auth.currentUser!.displayName
                });
                await firebaseFirestore
                    .collection('sellers')
                    .doc(widget.chatid)
                    .collection(auth.currentUser!.uid)
                    .add({
                  'message': _messageController.text,
                  'user': auth.currentUser!.displayName
                });
                _messageController.clear();
                value = null;
              }
            },
            icon: Icon(
              Icons.mark_email_read_sharp,
              color: _messageController.text.isNotEmpty
                  ? Colors.cyan
                  : Colors.grey,
            ),
          )),
        ),
      ],
    ));
  }
}
