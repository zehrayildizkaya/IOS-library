import 'package:flutter/material.dart';
import 'package:library_zehra/kitap_ekle.dart';
import 'package:library_zehra/kitap_listele.dart';
import 'package:library_zehra/profil.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Kütüphanecilik', style: TextStyle(fontSize: 20)),
        backgroundColor: Color.fromARGB(255, 68, 132, 197),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 150, 15, 50),
        height: 300,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => KitapListele()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 20, 112, 149),
                      padding: const EdgeInsets.fromLTRB(70, 25, 70, 25),
                      shape: const StadiumBorder(
                        side: BorderSide(
                          color: Colors.white12,
                          width: 4,
                        ),
                      )),
                  child: const Text(
                    'Kitap Listesi',
                    style: TextStyle(fontSize: 25),
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => KitapEkle()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 20, 112, 149),
                      padding: const EdgeInsets.fromLTRB(70, 25, 70, 25),
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.white12, width: 4),
                      )),
                  child: const Text(
                    'KitapEkle',
                    style: TextStyle(fontSize: 25),
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Profil()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 20, 112, 149),
                      padding: const EdgeInsets.fromLTRB(70, 25, 70, 25),
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.white12, width: 4),
                      )),
                  child: const Text(
                    'Profil',
                    style: TextStyle(fontSize: 25),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
