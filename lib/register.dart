import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_zehra/login.dart';
import 'package:library_zehra/users_mail.dart';
import 'package:library_zehra/users_password.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late FirebaseAuth auth;
  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol', style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.blue,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 70),
              const Padding(padding: EdgeInsets.all(10.0)),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                child: UsersMail(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                  child: UsersPassword()),
              const SizedBox(height: 30),
              TextButton(
                onPressed: (() {
                  kayitYap(email, sifre);
                }),
                child: const Text(
                  "Kayıt Ol",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 0, 162, 199)),
                ),
                style: TextButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 0, 162, 199)),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updatePassword() async {
    final authUser = FirebaseAuth.instance.currentUser;
    if (authUser == null) return;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(authUser.uid);
    userRef.set({
      'email': authUser.email,
      'profilUrl':
          'https://firebasestorage.googleapis.com/v0/b/library-zehra.appspot.com/o/files%2Fprofil%2F8e80be7awhatsappprofilfotografi.jpg?alt=media&token=e2b6d0a5-b5cc-40db-9ead-c745d4ffd1b2'
    });
  }

  void createUserEmailAndPassword() async {
    var _userCredential = await auth.createUserWithEmailAndPassword(
        email: email.text, password: sifre.text);
    print(_userCredential.toString());
  }

  kayitYap(TextEditingController email, TextEditingController sifre) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.text, password: sifre.text)
        .then((user) {
      _updatePassword();
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => LoginPage()));
    });
  }
}
