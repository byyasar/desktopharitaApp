import 'dart:convert';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haritaapp/src/screen/harita_page_screen.dart';
import 'package:haritaapp/src/widgets/custom_buton.dart';
import 'package:kartal/kartal.dart';

class SoruPage extends StatefulWidget {
  SoruPage({Key? key}) : super(key: key);

  @override
  _SoruPageState createState() => _SoruPageState();
}

class _SoruPageState extends State<SoruPage> {
  List sorular = [];
  int? rastgelesayi;
  int? sorusayisi;

  @override
  void initState() {
    super.initState();
    sorulariOku();
  }

  Future<void> sorulariOku() async {
    final String response =
        await rootBundle.loadString('assets/data/sorular.json');
    final isData = await json.decode(response);

    setState(() {
      sorular = isData;
      sorusayisi = sorular.length;
      //print("sorusayısı ${sorusayisi!}");
      rastgelesayi = Random().nextInt(sorusayisi!);
      print("random ${rastgelesayi!}");
    });
  }

  get yenile {
    setState(() {
      rastgelesayi = Random().nextInt(sorular.length);
      print("random ${rastgelesayi!}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingActionButton,
      appBar: _appBar(context),
      body: sorular.length == 0
          ? Center(child: CircularProgressIndicator())
          : _container(context, sorular, rastgelesayi),
    );
  }

  get _floatingActionButton {
    return FloatingActionButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Yenile"),
            Icon(Icons.refresh),
          ],
        ),
        onPressed: () {
          yenile;
        });
  }
}

Container _container(BuildContext context, List? sorular, int? rastgelesayi) {
  print("gelensorular ${sorular!.length}");
  print("gelen raste ${rastgelesayi!}");

  return Container(
    //color: Colors.blueAccent.shade100,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: context.dynamicWidth(.64),
            child: soltaraf(context, sorular, rastgelesayi),
          ),
          Container(
            width: context.dynamicWidth(.34),
            child: sagtaraf(context, sorular, rastgelesayi),
          ),
        ],
      ),
    ),
  );
}

sagtaraf(BuildContext context, List testSorular, int rastgelesayi) {
  return Center(
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: testSorular[rastgelesayi]["secenekler"].length,
      itemBuilder: (BuildContext context, int i) => Container(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ButtonWidget(
              //ebat: Size(context.dynamicWidth(.01), 50),
              fontsize: 24,
              butonColor: Colors.blueAccent,
              butonIcon: Icon(Icons.circle, color: Colors.white),
              butonText: i == 0
                  ? "A-" + testSorular[rastgelesayi]["secenekler"][i].toString()
                  : i == 1
                      ? "B-" +
                          testSorular[rastgelesayi]["secenekler"][i].toString()
                      : i == 2
                          ? "C-" +
                              testSorular[rastgelesayi]["secenekler"][i]
                                  .toString()
                          : "D-" +
                              testSorular[rastgelesayi]["secenekler"][i]
                                  .toString(),
              onPressed: () {
                print("cevap seçenek ${testSorular[rastgelesayi]["cevap"]}");
                print(
                    "cevap seçenek ${testSorular[rastgelesayi]["secenekler"][i]}");
                print(i);
                if (testSorular[rastgelesayi]["cevap"] ==
                    testSorular[rastgelesayi]["secenekler"][i]) {
                  sesCal(true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HaritaPage(
                        cevap: testSorular[rastgelesayi]["sehir"],
                      ),
                    ),
                  );
                } else {sesCal(false);
                  _showMyDialog(context, false);
                  
                }
              }),
        ),
      ),
    ),
  );
}

soltaraf(BuildContext context, List sorular, int rastgelesayi) {
  return Column(
    children: [
      Expanded(
        flex: 12,
        child: _imageContainer(context, sorular, rastgelesayi),
      ),
      Spacer(flex: 1),
      Expanded(
        flex: 8,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              sorular[rastgelesayi]["bilgi"],
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
      ),
    ],
  );
}

Container _imageContainer(
    BuildContext context, List? sorular, int? rastgelesayi) {
  return Container(
    margin: EdgeInsets.all(5),
    width: double.infinity,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset(0, 2),
        ),
      ],
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.white,
    ),
    child: Image.asset("assets/images/${sorular![rastgelesayi!]["image"]}"),
  );
}

_appBar(
  BuildContext context,
) =>
    AppBar(title: Text('Kültürel mirasın adı ne?'));

Future<void> sesCal(bool durum) async{
  AudioCache player = AudioCache(prefix: 'assets/sounds/');
   durum == true ?await player.play('dogru.mp3') : await player.play('yanlis.mp3');
}

Future<void> _showMyDialog(BuildContext context, bool dogrumu) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: dogrumu == true
            ? const Text('Tebrikler', style: TextStyle(fontSize: 24))
            : const Text('Üzgünüm', style: TextStyle(fontSize: 24)),
        backgroundColor: dogrumu == true ? Colors.white : Colors.red,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              dogrumu == true
                  ? Text("Doğru cevap.", style: TextStyle(fontSize: 24))
                  : Text("Lütfen tekrar deneyin.",
                      style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Tamam', style: TextStyle(fontSize: 24)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
