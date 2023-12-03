import 'package:flutter/material.dart';
import 'package:random_chooser/models/tap.dart';

class TapCircle extends StatefulWidget {
  const TapCircle(
      {super.key, required this.taps, required this.animationValue});
  final List<Tap> taps;
  final double animationValue;

  @override
  State<TapCircle> createState() => _TapCircleState();
}

class _TapCircleState extends State<TapCircle> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _DrawTapCircle(widget.taps, widget.animationValue),
    );
  }
}

class _DrawTapCircle extends CustomPainter {
  _DrawTapCircle(this.taps, this.animationValue);
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
