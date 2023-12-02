import 'dart:async';

import 'package:flutter/material.dart';
import 'package:random_chooser/models/tap.dart';
import 'package:random_chooser/providers/tap_location_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_chooser/widgets/tap_circle.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  Timer? randomTapTimer;

  void _startRandomTapTimer() {
    randomTapTimer?.cancel(); // Cancel existing timer if any
    randomTapTimer = Timer(const Duration(seconds: 3), () {
      // if (ref.watch(newPointerEventProvider) == false) {
      ref.watch(tapCoordinatesProvider.notifier).chooseRandomTap();
      // }
      // ref
      //     .watch(newPointerEventProvider.notifier)
      //     .changePointerEvent(false); // Reset the flag after 3 seconds
    });
  }

  @override
  Widget build(BuildContext context) {
    var tapCoordinates = ref.watch(tapCoordinatesProvider.notifier);
    var offsets = ref.watch(tapCoordinatesProvider);
    // Timer to reset isNewPointerEvent after 3 seconds

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1a1a1a), Color(0xFF333333)],
        )),
        child: Listener(
          onPointerDown: (e) {
            int pointerId = e.pointer;
            double x = e.position.dx.round().toDouble();
            double y = (e.position.dy).round().toDouble();

            tapCoordinates
                .addCoordinates(Tap(id: pointerId, offset: Offset(x, y)));
            if (offsets.length > 1) {
              // ref
              //     .watch(newPointerEventProvider.notifier)
              //     .changePointerEvent(true);
              _startRandomTapTimer();
            }
          },
          onPointerMove: (e) {
            int pointerId = e.pointer;
            double x = e.position.dx.round().toDouble();
            double y = (e.position.dy).round().toDouble();

            tapCoordinates.moveCoordinates(
                offsets.firstWhere((element) => element.id == pointerId),
                Offset(x, y));
          },
          onPointerUp: (e) {
            int pointerId = e.pointer;
            double x = e.position.dx.round().toDouble();
            double y = (e.position.dy).round().toDouble();

            tapCoordinates
                .removeCoordinate(Tap(id: pointerId, offset: Offset(x, y)));
            if (offsets.length > 1) {
              // ref
              //     .watch(newPointerEventProvider.notifier)
              //     .changePointerEvent(true);
              _startRandomTapTimer();
            }
          },
          onPointerCancel: (e) {
            int pointerId = e.pointer;
            double x = e.position.dx.round().toDouble();
            double y = (e.position.dy).round().toDouble();

            tapCoordinates
                .removeCoordinate(Tap(id: pointerId, offset: Offset(x, y)));
          },
          child: CustomPaint(
            size: Size.infinite,
            painter: TapCircle(offsets),
          ),
        ),
      ),
    );
  }
}
