import 'package:flutter/material.dart';
import 'package:random_chooser/models/tap.dart';

class TapCircle extends CustomPainter {
  TapCircle(this.taps, this.animationValue);
  List<Tap> taps;
  double animationValue;
  @override
  void paint(Canvas canvas, Size size) {
    for (Tap tap in taps) {
      tap.isChosen
          ? canvas.drawCircle(
              tap.offset,
              85,
              Paint()
                ..color = Colors.white
                ..style = PaintingStyle.fill)
          : drawAnimatedCircle(canvas, tap.offset);
    }
  }

  void drawAnimatedCircle(Canvas canvas, Offset offset) {
    canvas.drawCircle(
        offset,
        60 + 20 * animationValue,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 20);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
