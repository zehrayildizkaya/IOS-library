import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_zehra/kutu.dart';

class FavoriKitaplar extends StatelessWidget {
  const FavoriKitaplar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kitaplar', style: TextStyle(fontSize: 20)),
          backgroundColor: Colors.teal.shade800,
        ),
        body: Kutu(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('favoriler')
                              .snapshots(),
                          builder: (context, snapshots) {
                            if (!snapshots.hasData)
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            final users = snapshots.data!.docs;

                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Column(children: [
                                    Text("Kitap Adı : " + users[index]['isim'],
                                        style: TextStyle(fontSize: 16)),
                                    Text(
                                        "Sayfa Sayısı :  " +
                                            users[index]['sayfa'],
                                        style: TextStyle(fontSize: 16)),
                                    Text(
                                        "Kitabın Yazarı : " +
                                            users[index]['yazar'],
                                        style: TextStyle(fontSize: 16)),
                                    IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {
                                          await users[index].reference.delete();
                                        }),
                                  ]),
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
