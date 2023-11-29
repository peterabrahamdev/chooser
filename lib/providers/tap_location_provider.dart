import 'package:riverpod/riverpod.dart';

class TapCoordinatesNotifier extends StateNotifier<List<double>> {
  TapCoordinatesNotifier() : super([0.0, 0.0]);

  void addCoordinates(double x, double y) {
    state = [x, y];
  }

  double getX() {
    return state[0];
  }

  double getY() {
    return state[1];
  }
}

final tapCoordinatesProvider =
    StateNotifierProvider<TapCoordinatesNotifier, List<double>>(
        (ref) => TapCoordinatesNotifier());
