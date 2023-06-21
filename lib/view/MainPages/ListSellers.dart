import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fr/view/MainPages/ListFreeOrders.dart';
import 'package:fr/view/ProfileSeller.dart';
import '../../firebase/auth/auth_controller.dart';

final AuthController _authController = AuthController();

class ListSellers extends StatefulWidget {
  const ListSellers({Key? key}) : super(key: key);

  @override
  State<ListSellers> createState() => _HomePageState();
}

class _HomePageState extends State<ListSellers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
            body: Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Имя'),
            Text('Регион'),
            Text('Рейтнг'),
          ],
        ),
        StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('sellers').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('жопа');
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
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var sellers = snapshot.data!.docs[index];

                        return TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileSellerPage(
                                            username: sellers.get('username'),
                                            rating: sellers.get('rating'),
                                            region: sellers.get('region'),
                                            uids: sellers.get('uid'),
                                          )));
                            },
                            child: Card(
                                child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(sellers.get('username')),
                                    Text(sellers.get('region')),
                                    Text(sellers.get('rating')),
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                )
                              ],
                            )));
                      }));
            }), //конец раздела продавцов
        Container(
          //начало раздела анкет
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('ankets').snapshots(),
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

              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var anketss = snapshot.data!.docs[index];
                          return Card(
                            child: Column(
                              children: [
                                Image(
                                  image: NetworkImage(
                                      'https://myalpins.com/1686-thickbox_default/nike-air-jordan-1-mid-%D0%B4%D1%8B%D0%BC%D1%87%D0%B0%D1%82%D1%8B%D0%B9-%D1%81%D0%B5%D1%80%D1%8B%D0%B9.jpg'),
                                  height: 75,
                                  width: 75,
                                ),
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
                                          color: Colors.lightGreen,
                                          fontSize: 16),
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
                          );
                        }),
                  ));
            },
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListFreeOrders()));
            },
            child: const Text('Развернуть...')),
      ],
    )));
  }
}
