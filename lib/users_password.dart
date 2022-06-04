import 'package:flutter/material.dart';

class UsersPassword extends StatefulWidget {
  const UsersPassword({Key? key}) : super(key: key);

  @override
  State<UsersPassword> createState() => _UsersPasswordState();
}

    TextEditingController sifre = TextEditingController();
class _UsersPasswordState extends State<UsersPassword> {
  bool showPassword = true;

  bool showConfirmPassword = true;

  late FocusNode passwordFocusNode;

  late FocusNode confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: sifre,
      // obscureText: true,
      obscureText: showPassword,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 0, 162, 199)),
        ),
        prefixIcon: const Icon(
          Icons.key,
          color: Color.fromARGB(255, 0, 162, 199),
        ),
        labelText: "Şifre",
        labelStyle: const TextStyle(
          color: (Color.fromARGB(255, 0, 162, 199)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(18.0),
          ),
        ),
        suffixIcon: IconButton(
            icon: const Icon(Icons.remove_red_eye),
            onPressed: () => setState(() {
                  showPassword = !showPassword;
                })),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Şifre Giriniz";
        } else {
          return null;
        }
      },
    );
  }
}