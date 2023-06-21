import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListFreeOrders extends StatefulWidget {
  const ListFreeOrders({Key? key}) : super(key: key);

  @override
  State<ListFreeOrders> createState() => _ListFreeOrdersState();
}

class _ListFreeOrdersState extends State<ListFreeOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('ankets').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('легло (читай доку)');
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Бренд: ',
                                  style: TextStyle(
                                      color: Colors.amber, fontSize: 16),
                                ),
                                Text('${anketss.get('brand')}'),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Марка: ',
                                  style: TextStyle(
                                      color: Colors.lightGreen, fontSize: 16),
                                ),
                                Text('${anketss.get('productBrand')}'),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Модель: ',
                                  style: TextStyle(
                                      color: Colors.purple, fontSize: 16),
                                ),
                                Text('${anketss.get('productName')}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
