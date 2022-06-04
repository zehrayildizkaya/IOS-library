import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_zehra/kitap_listele.dart';

class KitapEkle extends StatefulWidget {
  KitapEkle({Key? key}) : super(key: key);

  @override
  State<KitapEkle> createState() => _KitapEkleState();
}

class _KitapEkleState extends State<KitapEkle> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController kitap_adi = TextEditingController();
  TextEditingController kitap_sayfa = TextEditingController();
  TextEditingController kitap_yazar = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CollectionReference booksRef = _firestore.collection('kitapbilgi');
    return Scaffold(
        appBar: AppBar(
          title: const Text('KİTAP EKLE', style: TextStyle(fontSize: 20)),
          backgroundColor: Color.fromARGB(255, 53, 110, 172),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: kitap_adi,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelText: "Kitap Adı",
                      labelStyle: TextStyle(
                        color: (Color.fromARGB(255, 20, 45, 119)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 23, 87, 25)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Kitap adı giriniz.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: kitap_sayfa,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelText: "Kitap Sayfa Sayısı",
                      labelStyle: TextStyle(
                        color: (Color.fromARGB(255, 20, 42, 102)),
                      ),
                      border: OutlineInputBorder(
                        gapPadding: 4.0,
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 23, 87, 25)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Kitap Sayfa Sayısı Giriniz.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: kitap_yazar,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelText: "Yazar",
                      labelStyle: TextStyle(
                        color: (Color.fromARGB(255, 42, 43, 130)),
                      ),
                      border: OutlineInputBorder(
                        gapPadding: 4.0,
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 23, 87, 25)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Yazarın ismini giriniz.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: (() {
                      Map<String, dynamic> kitapData = {
                        'isim': kitap_adi.text,
                        'sayfa': kitap_sayfa.text,
                        'yazar': kitap_yazar.text
                      };
                      booksRef.doc(kitap_adi.text).set(kitapData);

                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => KitapListele()));
                    }),
                    child: const Text(
                      "Kitabı Kaydet",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 162, 199)),
                    ),
                    style: TextButton.styleFrom(
                        side: const BorderSide(
                            color: Color.fromARGB(255, 0, 162, 199)),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }
}
