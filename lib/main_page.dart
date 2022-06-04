import 'package:flutter/material.dart';
import 'package:library_zehra/kutu.dart';
import 'package:library_zehra/login.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Kutu(
            child: Center(
      child: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          SizedBox(
              width: 300,
              height: 50,
              child: Center(
                child: Text("KÜTÜPHANECİLİK",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white)),
              )),
          SizedBox(
            height: 100,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 49, 110, 161),
                  padding: const EdgeInsets.fromLTRB(65, 20, 65, 20),
                  shape: const StadiumBorder(
                    side: BorderSide(
                      color: Color.fromARGB(232, 255, 255, 255),
                      width: 4,
                    ),
                  )),
              child: const Text(
                'BAŞLA',
                style: TextStyle(fontSize: 30),
              )),
        ],
      ),
    )));
  }
}
