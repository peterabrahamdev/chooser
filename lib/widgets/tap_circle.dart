import 'package:flutter/material.dart';

class TapCircle extends CustomPainter {
  TapCircle(this.offset, this.appBarHeight);
  Offset offset;
  double appBarHeight;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(offset.dx, offset.dy - appBarHeight), 50, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
