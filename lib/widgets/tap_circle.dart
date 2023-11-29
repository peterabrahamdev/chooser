import 'package:flutter/material.dart';

class TapCircle extends CustomPainter {
  TapCircle(this.offset);
  List<double> offset;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(offset[0], offset[1]), 50, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
