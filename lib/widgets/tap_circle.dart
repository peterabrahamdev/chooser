import 'package:flutter/material.dart';
import 'package:random_chooser/models/tap.dart';

class TapCircle extends CustomPainter {
  TapCircle(this.taps);
  List<Tap> taps;
  @override
  void paint(Canvas canvas, Size size) {
    for (Tap tap in taps) {
      canvas.drawCircle(
          tap.offset,
          50,
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = 10);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
