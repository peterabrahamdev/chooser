import 'package:random_chooser/models/tap.dart';
import 'package:riverpod/riverpod.dart';

class TapCoordinatesNotifier extends StateNotifier<List<Tap>> {
  TapCoordinatesNotifier() : super(<Tap>[]);

  void addCoordinates(Tap tap) {
    state = <Tap>[...state, tap];
  }

  void moveCoordinates(Tap tap) {
    int index = state.indexWhere((element) => element.id == tap.id);
    if (index != -1) {
      state = [
        ...state.sublist(0, index),
        tap,
        ...state.sublist(index + 1),
      ];
    }
  }

  void removeCoordinate(Tap tap) {
    state = state.where((element) => element.id != tap.id).toList();
  }
}

final tapCoordinatesProvider =
    StateNotifierProvider<TapCoordinatesNotifier, List<Tap>>(
        (ref) => TapCoordinatesNotifier());
