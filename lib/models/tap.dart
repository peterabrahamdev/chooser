import 'package:flutter/material.dart';

class Tap {
  const Tap({required this.id, required this.offset, this.isChosen = false});

  final int id;
  final Offset offset;
  final bool isChosen;
}
