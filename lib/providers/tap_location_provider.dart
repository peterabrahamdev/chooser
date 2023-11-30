import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class TapCoordinatesNotifier extends StateNotifier<Offset> {
  TapCoordinatesNotifier() : super(const Offset(0, 0));

  void addCoordinates(Offset offset) {
    state = offset;
  }
}

final tapCoordinatesProvider =
    StateNotifierProvider<TapCoordinatesNotifier, Offset>(
        (ref) => TapCoordinatesNotifier());
