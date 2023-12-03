import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:random_chooser/models/tap.dart';

class TapCircle extends CustomPainter {
  TapCircle(this.taps);
  List<Tap> taps;
  @override
  void paint(Canvas canvas, Size size) {
    for (Tap tap in taps) {
      tap.isChosen
          ? canvas.drawCircle(
              tap.offset,
              70,
              Paint()
                ..color = Colors.white
                ..style = PaintingStyle.fill)
          : canvas.drawCircle(
              tap.offset,
              60,
              Paint()
                ..color = Colors.white
                ..style = PaintingStyle.stroke
                ..strokeWidth = 10);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
