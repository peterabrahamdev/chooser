import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class TapCoordinatesNotifier extends StateNotifier<Map<int, Offset>> {
  TapCoordinatesNotifier() : super({});

  void addCoordinates(int id, Offset offset) {
    state = {...state, id: offset};
  }

  void moveCoordinates(int id, Offset offset) {
    if (state.containsKey(id)) {
      state = {...state, id: offset};
    }
  }

  void removeCoordinate(int id, Offset offset) {
    if (state.containsKey(id)) {
      state = Map.fromEntries(
          state.entries.where((element) => element.key != id));
    }
  }
}

final tapCoordinatesProvider =
    StateNotifierProvider<TapCoordinatesNotifier, Map<int, Offset>>(
        (ref) => TapCoordinatesNotifier());
