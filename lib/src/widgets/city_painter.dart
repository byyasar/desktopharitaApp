import 'package:flutter/material.dart';

import '../../city_picker_from_map.dart';
import '../size_controller.dart';
import 'dart:ui' as ui;

class CityPainter extends CustomPainter {
  final City city;
  final City? selectedCity;
  final Color? strokeColor;
  final Color? selectedColor;
  final Color? dotColor;

  final sizeController = SizeController.instance;

  double _scale = 1.0;

  CityPainter(
      {required this.city,
      required this.selectedCity,
      this.selectedColor,
      this.strokeColor,
      this.dotColor});

  @override
  void paint(Canvas canvas, Size size) {
    final pen = Paint()
      ..color = strokeColor ?? Colors.pink
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final selectedPen = Paint()
      ..color = selectedColor ?? Colors.blue
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;

    final redDot = Paint()
      ..color = dotColor ?? Colors.red
      ..strokeWidth = 3.0
      ..style = PaintingStyle.fill;

    final bounds = city.path.getBounds();

    _scale = sizeController.calculateScale(size);
    canvas.scale(_scale);

    if (city.id == selectedCity?.id) {
      canvas.drawPath(city.path, selectedPen);
    }
    final textStyle = ui.TextStyle(
        color: Colors.black, fontSize: 7, fontWeight: FontWeight.bold);
    final paragraphStyle = ui.ParagraphStyle(
      textDirection: TextDirection.ltr,
    );
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText("${city.title}");
    final constraints = ui.ParagraphConstraints(width: 300);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(constraints);

    final double geri = city.title.length * 2.0;
    double yukari = 0.0;
    city.title == "Antalya" ||
            city.title == "Ağrı" ||
            city.title == "Hakkâri" ||
            city.title == "Gümüşhane" ||
            city.title == "Karaman"
        ? yukari = 12.0
        : city.title == "Muğla" || city.title == "Burdur"
            ? yukari = 14.0
            : city.title == "İzmir" ||
                    city.title == "Balıkesir" ||
                    city.title == "Osmaniye" ||
                    city.title == "Çanakkale" ||
                    city.title == "Erzincan" ||
                    city.title == "Edirne"
                ? yukari = -10.0
                : yukari = 0;

    final offsetText =
        Offset(bounds.center.dx - geri, bounds.center.dy - yukari);

    canvas.drawCircle(
        Offset(bounds.center.dx, bounds.center.dy - yukari - 1), 3.0, redDot);
    canvas.drawParagraph(paragraph, offsetText);
    canvas.drawPath(city.path, pen);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  bool hitTest(Offset position) {
    double inverseScale = sizeController.inverseOfScale(_scale);
    return city.path.contains(position.scale(inverseScale, inverseScale));
  }
}
