import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class TapCoordinatesNotifier extends StateNotifier<Map<int, Offset>> {
  TapCoordinatesNotifier() : super({});

  int _nextId = 1;
  void addCoordinates(Offset offset) {
    state = {...state, _nextId: offset};
    _nextId++;
  }

  void moveCoordinates(int id, Offset offset) {
    if (state.containsKey(id)) {
      state = {...state, id: offset};
    }
  }

  void removeCoordinate(int id, Offset offset) {
    if (state.containsKey(id)) {
      state = Map.fromEntries(
          state.entries.where((element) => element != element.key));
    }
  }
}

final tapCoordinatesProvider =
    StateNotifierProvider<TapCoordinatesNotifier, Map<int, Offset>>(
        (ref) => TapCoordinatesNotifier());
