import 'package:flutter/material.dart';

class TapCircle extends CustomPainter {
  TapCircle(this.offsets, this.appBarHeight);
  List<Offset> offsets;
  double appBarHeight;
  @override
  void paint(Canvas canvas, Size size) {
    for (Offset offset in offsets) {
      canvas.drawCircle(
          Offset(offset.dx, offset.dy - appBarHeight),
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
