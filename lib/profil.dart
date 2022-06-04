import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_zehra/fav.dart';
import 'package:library_zehra/login.dart';
import 'package:library_zehra/okunacak.dart';
import 'package:library_zehra/okunan.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:library_zehra/updatepass.dart';
import 'package:path/path.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  late FirebaseAuth auth;
  late String url;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _foto;
  final ImagePicker _sec = ImagePicker();

  Future galeri() async {
    final secilendosya = await _sec.pickImage(source: ImageSource.gallery);

    setState(() {
      if (secilendosya != null) {
        _foto = File(secilendosya.path);
        uploadFile();
      } else {
        print('Resim seçilmedi');
      }
    });
  }

  Future kamera() async {
    final secilendosya = await _sec.pickImage(source: ImageSource.camera);

    setState(() {
      if (secilendosya != null) {
        _foto = File(secilendosya.path);
        uploadFile();
      } else {
        print('Resim seçilmedi');
      }
    });
  }

  Future uploadFile() async {
    if (_foto == null) return;
    final fileName = basename(_foto!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_foto!);
      url = (await ref.getDownloadURL()).toString();
      _updateUsers();
    } catch (e) {
      print('hata');
    }
  }

  Future<void> _updateUsers() async {
    final authUser = FirebaseAuth.instance.currentUser;
    if (authUser == null) return;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(authUser.uid);
    final userDoc = await userRef.get();
    userRef.update({'profilUrl': url});
  }

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        const Text('Oturum kapalı');
      } else {
        Text('Oturum Açık ${user.email} ve email durumu ${user.emailVerified}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil', style: TextStyle(fontSize: 20)),
        backgroundColor: Color.fromARGB(255, 34, 61, 126),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    _secme(context);
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Color.fromARGB(255, 123, 152, 210),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .snapshots(),
                          builder: (context, snapshots) {
                            if (!snapshots.hasData) return Center();
                            final users = snapshots.data!.docs;
                            return Image.network(users[0]['profilUrl']);
                          }),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, snapshots) {
                      if (!snapshots.hasData) return Center();
                      final users = snapshots.data!.docs;
                      return Column(
                        children: [
                          Text("Email: ${users[0]['email']}",
                              style: TextStyle(fontSize: 20)),
                        ],
                      );
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FavoriKitaplar()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 50, 71, 142),
                      padding: const EdgeInsets.fromLTRB(60, 20, 60, 20),
                      shape: const StadiumBorder(
                        side: BorderSide(
                            color: Color.fromARGB(255, 19, 7, 69), width: 4),
                      )),
                  child: const Text(
                    'Favori Kitaplar',
                    style: TextStyle(fontSize: 17),
                  )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Okunanlar()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 50, 71, 142),
                      padding: const EdgeInsets.fromLTRB(70, 20, 70, 20),
                      shape: const StadiumBorder(
                        side: BorderSide(
                            color: Color.fromARGB(255, 19, 7, 69), width: 4),
                      )),
                  child: const Text(
                    'Okuduğum Kitaplar',
                    style: TextStyle(fontSize: 17),
                  )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Okunacak()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 50, 71, 142),
                      padding: const EdgeInsets.fromLTRB(70, 20, 70, 20),
                      shape: const StadiumBorder(
                        side: BorderSide(
                            color: Color.fromARGB(255, 19, 7, 69), width: 4),
                      )),
                  child: const Text(
                    'Okuyacağım Kitaplar',
                    style: TextStyle(fontSize: 17),
                  )),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: (() {
                  signOutUser();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UpdatePassword()));
                }),
                child: const Text(
                  "Şifre Değiştirme",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 0, 162, 199)),
                ),
                style: TextButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 0, 162, 199)),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
              ),
              TextButton(
                onPressed: (() {
                  signOutUser();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }),
                child: const Text(
                  "Oturumu Kapat",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 0, 162, 199)),
                ),
                style: TextButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 0, 162, 199)),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
              ),
            ]),
      ),
    );
  }

  void _secme(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeriden seç'),
                      onTap: () {
                        galeri();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Kamera'),
                    onTap: () {
                      kamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void signOutUser() async {
    await auth.signOut();
  }
}
