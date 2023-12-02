import 'dart:math';
import 'package:flutter/material.dart';

import 'package:random_chooser/models/tap.dart';
import 'package:riverpod/riverpod.dart';

class TapCoordinatesNotifier extends StateNotifier<List<Tap>> {
  TapCoordinatesNotifier() : super(<Tap>[]);

  void addCoordinates(Tap tap) {
    state = <Tap>[...state, tap];
  }

  void moveCoordinates(Tap tap, Offset offset) {
    int index = state.indexWhere((element) => element.id == tap.id);
    if (index != -1) {
      state = [
        ...state.sublist(0, index),
        Tap(id: tap.id, offset: offset, isChosen: tap.isChosen),
        ...state.sublist(index + 1),
      ];
    }
  }

  void removeCoordinate(Tap tap) {
    state = state.where((element) => element.id != tap.id).toList();
  }

  void chooseRandomTap() {
    Random random = Random();
    int randomIndex = random.nextInt(state.length);
    var chosenTap = state[randomIndex];
    state = [
      ...state.sublist(0, randomIndex),
      Tap(id: chosenTap.id, offset: chosenTap.offset, isChosen: true),
      ...state.sublist(randomIndex + 1),
    ];
  }
}

final tapCoordinatesProvider =
    StateNotifierProvider<TapCoordinatesNotifier, List<Tap>>(
        (ref) => TapCoordinatesNotifier());
