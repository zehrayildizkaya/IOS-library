import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_zehra/login.dart';

class UpdatePassword extends StatefulWidget {
  UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _formKey = GlobalKey<FormState>();
  var newPassword;
  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;

  changePassword() async {
    try {
      print("dasfsf");
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Şifre Değiştirme', style: TextStyle(fontSize: 20)),
        backgroundColor: Color.fromARGB(255, 13, 93, 26),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: ListView(children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Yeni Şifre: ",
                            hintText: "Yeni Şifre Girin",
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 150)),
                        controller: newPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen Şifre girin';
                          }
                          return null;
                        })),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        newPassword = newPasswordController.text;
                      });
                      changePassword();
                    }
                  },
                  child:
                      Text('Şifreyi Değiştir', style: TextStyle(fontSize: 20)),
                )
              ]))),
    );
  }
}
