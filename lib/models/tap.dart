import 'package:flutter/material.dart';

class Tap {
  Tap({required this.id, required this.offset, this.isChosen = false});

  final int id;
  final Offset offset;
  bool isChosen;

  Tap copyWith({
    bool? isChosen,
    Offset? offset,
  }) {
    return Tap(
      id: id,
      offset: offset ?? this.offset,
      isChosen: isChosen ?? this.isChosen,
    );
  }
}
