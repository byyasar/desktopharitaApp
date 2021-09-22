import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haritaapp/city_picker_from_map.dart';
import 'package:haritaapp/src/screen/ana_page_screen.dart';
import 'package:kartal/kartal.dart';
import 'package:audioplayers/audioplayers.dart';

class HaritaPage extends StatefulWidget {
  String? cevap;
  HaritaPage({Key? key, this.cevap}) : super(key: key);

  @override
  _HaritaPageState createState() => _HaritaPageState();
}

class _HaritaPageState extends State<HaritaPage> {
  City? selectedCity;
  final GlobalKey<CityPickerMapState> _mapKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    //print("Gelen şehir ${widget.cevap}");
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Kültürel mirasımız hangi şehirde?'),
            Text(' ---> '),
            Text('Seçilen Şehir: ${selectedCity?.title ?? '(?)'}'),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _mapKey.currentState?.clearSelect();
                setState(() {
                  selectedCity = null;
                });
              }),
          IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnaPage()),
                );
              })
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        height: context.dynamicHeight(1),
        width: context.dynamicWidth(1),
        child: InteractiveViewer(
          scaleEnabled: true,
          panEnabled: true,
          constrained: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
            child: CityPickerMap(
              key: _mapKey,
              width: double.infinity,
              height: double.infinity,
              map: Maps.TURKEY,
              onChanged: (city) {
                //print("Gelen şehir ${widget.cevap}");
                setState(() {
                  selectedCity = city;
                  print('seçilen şehir ' + city!.title.toString());
                  print("Gelen şehir ${widget.cevap}");
                  if ("${widget.cevap}" == city.title.toString()) {
                    sesCal(true);
                    _showMyDialog(context, true);
                  } else {
                    sesCal(false);
                    _showMyDialog(context, false);
                  }
                });
              },
              actAsToggle: true,
              dotColor: Colors.orange, //haritadaki illerin noktası
              selectedColor: Colors.lightBlueAccent,
              strokeColor: Colors.purple, //harita çizgi rengi
            ),
          ),
        ),
      ),
    );
  }
}
Future<void> sesCal(bool durum) async{
  AudioCache player = AudioCache(prefix: 'assets/sounds/');
   durum == true ?await player.play('alkis.mp3') : await player.play('yanlis.mp3');
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
