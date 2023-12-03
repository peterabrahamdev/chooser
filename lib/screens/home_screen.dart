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
      ref.watch(tapCoordinatesProvider.notifier).chooseRandomTap();
    });
  }

  @override
  Widget build(BuildContext context) {
    var tapCoordinates = ref.watch(tapCoordinatesProvider.notifier);
    var offsets = ref.watch(tapCoordinatesProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF662D8C), Color(0xFFED1E79)],
        )),
        child: Listener(
          onPointerDown: (e) {
            int pointerId = e.pointer;
            double x = e.position.dx.round().toDouble();
            double y = (e.position.dy).round().toDouble();

            tapCoordinates
                .addCoordinates(Tap(id: pointerId, offset: Offset(x, y)));
            if (offsets.length > 1) {
              _startRandomTapTimer();
            }
          },
          onPointerMove: (e) {
            int pointerId = e.pointer;
            double x = e.position.dx.round().toDouble();
            double y = (e.position.dy).round().toDouble();

            var targetIndex =
                offsets.indexWhere((element) => element.id == pointerId);
            if (targetIndex != -1) {
              // Update the offset using the new position
              tapCoordinates.moveCoordinates(
                  offsets[targetIndex], Offset(x, y));
            }
          },
          onPointerUp: (e) {
            int pointerId = e.pointer;
            double x = e.position.dx.round().toDouble();
            double y = (e.position.dy).round().toDouble();

            tapCoordinates
                .removeCoordinate(Tap(id: pointerId, offset: Offset(x, y)));
            if (offsets.length > 1) {
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
