import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class TapCoordinatesNotifier extends StateNotifier<List<Offset>> {
  TapCoordinatesNotifier() : super([]);

  void addCoordinates(Offset offset) {
    state = [...state, offset];
  }

  void removeCoordinate(Offset offset) {
    state = state.where((element) => element != offset).toList();
  }
}

final tapCoordinatesProvider =
    StateNotifierProvider<TapCoordinatesNotifier, List<Offset>>(
        (ref) => TapCoordinatesNotifier());
