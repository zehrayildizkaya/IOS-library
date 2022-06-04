import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_zehra/kitap_ekle.dart';
import 'package:library_zehra/kutu.dart';

class KitapListele extends StatefulWidget {
  const KitapListele({Key? key}) : super(key: key);

  @override
  State<KitapListele> createState() => _KitapListeleState();
}

class _KitapListeleState extends State<KitapListele> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference booksRef = _firestore.collection('favoriler');
    CollectionReference booksRef2 = _firestore.collection('okudum');
    CollectionReference booksRef3 = _firestore.collection('okuyacağım');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kitaplar', style: TextStyle(fontSize: 20)),
          backgroundColor: Colors.teal.shade800,
          actions: <Widget>[
            new IconButton(
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => KitapEkle()));
                },
                icon: new Icon(Icons.add_card))
          ],
        ),
        body: Kutu(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('kitapbilgi')
                              .snapshots(),
                          builder: (context, snapshots) {
                            if (!snapshots.hasData)
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            final users = snapshots.data!.docs;

                            return ListView.builder(
                              itemBuilder: (context, index) {
                                var ad = users[index]['isim'];
                                var sayfa = users[index]['sayfa'];
                                var yazar = users[index]['yazar'];
                                return Column(
                                  children: [
                                    Card(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Kitap Adı : " +
                                                        users[index]['isim'],
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                Text(
                                                    "Sayfa Sayısı :  " +
                                                        users[index]['sayfa'],
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                Text(
                                                    "Kitabın Yazarı : " +
                                                        users[index]['yazar'],
                                                    style:
                                                        TextStyle(fontSize: 16))
                                              ]),
                                          Row(children: [
                                            IconButton(
                                                onPressed: () {
                                                  Map<String, dynamic>
                                                      kitapData = {
                                                    'isim': ad,
                                                    'sayfa': sayfa,
                                                    'yazar': yazar
                                                  };
                                                  booksRef.doc().set(kitapData);
                                                },
                                                icon: Icon(
                                                  Icons.star_border,
                                                  size: 30,
                                                )),
                                            SizedBox(width: 10),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Map<String, dynamic>
                                                      kitapData = {
                                                    'isim': ad,
                                                    'sayfa': sayfa,
                                                    'yazar': yazar
                                                  };
                                                  booksRef2
                                                      .doc()
                                                      .set(kitapData);
                                                },
                                                child: Text("Okudum")),
                                            SizedBox(width: 10),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Map<String, dynamic>
                                                      kitapData = {
                                                    'isim': ad,
                                                    'sayfa': sayfa,
                                                    'yazar': yazar
                                                  };
                                                  booksRef3
                                                      .doc()
                                                      .set(kitapData);
                                                },
                                                child: Text("Okuyacağım")),
                                            IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () async {
                                                  await users[index]
                                                      .reference
                                                      .delete();
                                                }),
                                          ])
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                              itemCount: users.length,
                            );
                          }),
                    ),
                  ],
                ))));
  }
}
