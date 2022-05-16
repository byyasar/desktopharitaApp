import 'package:flutter/material.dart';
import 'package:haritaapp/src/screen/ana_page_screen.dart';
import 'package:haritaapp/src/screen/harita_page_screen.dart';
//import 'package:haritaapp/src/screen/ses_cal.dart';
import 'package:haritaapp/src/screen/soru_page_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? _sehir;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kültürel Miraslarımız',
      //home: MainPage(),
      //theme: ThemeData.light(),
      initialRoute: "/",
      routes: {
        "/": (context) => const AnaPage(),
        //"/sese": (context) => MyApp(),
        "/soru": (context) => const SoruPage(),
        //"/secim": (context) => MainPage(),
        "/harita": (context) => HaritaPage(
              cevap: _sehir,
            ),
      },
    );
  }
}
