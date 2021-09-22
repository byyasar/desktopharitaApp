//List<Sorular> sorularFromJson(String str) => List<Sorular>.from(json.decode(str).map((x) => Sorular.fromJson(x)));

//String sorularToJson(List<Sorular> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

import 'package:vexana/vexana.dart';

class Sorular extends INetworkModel<Sorular> {
  final int? id;
  final String? image;
  final String? bilgi;
  final Secenekler? secenekler;
  final String? cevap;
  final String? sehir;
  Sorular(
      {this.id,
      this.image,
      this.bilgi,
      this.secenekler,
      this.cevap,
      this.sehir});
  @override
  Sorular fromJson(Map<String, dynamic> json) {
    return Sorular.fromJson(json);
  }

  factory Sorular.fromJson(Map<String, dynamic> json) => Sorular(
        id: json["id"],
        image: json["image"],
        bilgi: json["bilgi"],
        secenekler: Secenekler.fromJson(json["secenekler"]),
        cevap: json["cevap"],
        sehir: json["sehir"],
      );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['bilgi'] = this.bilgi;
    if (this.secenekler != null) {
      data['secenekler'] = this.secenekler!.toJson();
    }
    data['cevap'] = this.cevap;
    data['sehir'] = this.sehir;
    return data;
  }
}

class Secenekler {
  Secenekler({
    required this.a,
    required this.b,
    required this.c,
    required this.d,
  });

  final String a;
  final String b;
  final String c;
  final String d;

  factory Secenekler.fromJson(Map<String, dynamic> json) => Secenekler(
        a: json["a"],
        b: json["b"],
        c: json["c"],
        d: json["d"],
      );

  Map<String, dynamic> toJson() => {
        "a": a,
        "b": b,
        "c": c,
        "d": d,
      };
}
