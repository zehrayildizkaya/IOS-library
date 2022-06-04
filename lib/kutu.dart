import 'package:flutter/material.dart';

class Kutu extends StatelessWidget {
  const Kutu({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 144, 190, 226),
          Color.fromARGB(255, 9, 73, 74)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: child,
    );
  }
}
