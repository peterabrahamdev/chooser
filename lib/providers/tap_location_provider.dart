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
    // Handles the case when the list is empty
    // Otherwise Random.nextInt is being called with an argument of 0 when state.length is 0.
    // This results in a RangeError because nextInt requires a positive maximum value.
    if (state.isEmpty) {
      return;
    }
    Random random = Random();
    int randomIndex = random.nextInt(state.length);
    Tap chosenTap = state[randomIndex].copyWith(isChosen: true);

    state = [
      chosenTap,
    ];
    print('${chosenTap.id}, ${chosenTap.offset}, ${chosenTap.isChosen}');
  }
}

final tapCoordinatesProvider =
    StateNotifierProvider<TapCoordinatesNotifier, List<Tap>>(
        (ref) => TapCoordinatesNotifier());

class NewPointerEventNotifier extends StateNotifier<bool> {
  NewPointerEventNotifier() : super(false);

  void changePointerEvent(bool isNewPointerEvent) {
    state = isNewPointerEvent;
  }
}

final newPointerEventProvider =
    StateNotifierProvider<NewPointerEventNotifier, bool>(
        (ref) => NewPointerEventNotifier());
