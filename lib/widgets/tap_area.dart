import 'package:flutter/material.dart';
import 'package:random_chooser/widgets/tap_circle.dart';

class TapArea extends StatefulWidget {
  const TapArea({super.key});

  @override
  State<TapArea> createState() => _TapAreaState();
}

class _TapAreaState extends State<TapArea> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TapCircle(),
    );
  }
}
