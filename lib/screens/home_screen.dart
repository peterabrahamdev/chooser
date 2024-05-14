import 'dart:async';

import 'package:flutter/material.dart';
import 'package:random_chooser/models/tap.dart';
import 'package:random_chooser/providers/tap_location_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_chooser/widgets/tap_circle.dart';
import 'package:vibration/vibration.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>
    with SingleTickerProviderStateMixin {
  Timer? randomTapTimer;
  var isScreenTapped = false;
  late AnimationController animationController;
  late CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

    animationController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    randomTapTimer!.cancel();
    animationController.dispose();
    super.dispose();
  }

  void _startRandomTapTimer() {
    int seconds = 3;
    randomTapTimer?.cancel(); // Cancel existing timer if any
    randomTapTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      animationController.repeat(reverse: true);
      seconds--;
      Vibration.vibrate(duration: 10, amplitude: 200);
      if (seconds == 0) {
        Vibration.vibrate(duration: 30, amplitude: 20);
        timer.cancel();
        ref.watch(tapCoordinatesProvider.notifier).chooseRandomTap();
        animationController.stop();
      }
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
            setState(() {
              isScreenTapped = true;
            });
            Vibration.vibrate(duration: 10, amplitude: 10);
            int pointerId = e.pointer;
            double x = e.position.dx.round().toDouble();
            double y = (e.position.dy).round().toDouble();

            tapCoordinates
                .addCoordinates(Tap(id: pointerId, offset: Offset(x, y)));
            if (ref.watch(tapCoordinatesProvider).length > 1) {
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
            if (ref.watch(tapCoordinatesProvider).length > 1) {
              _startRandomTapTimer();
            } else {
              randomTapTimer?.cancel();
              setState(() {
                isScreenTapped = false;
              });
              animationController.reset();
            }
          },
          onPointerCancel: (e) {
            int pointerId = e.pointer;
            double x = e.position.dx.round().toDouble();
            double y = (e.position.dy).round().toDouble();

            tapCoordinates
                .removeCoordinate(Tap(id: pointerId, offset: Offset(x, y)));
          },
          child: Stack(children: [
            if (!isScreenTapped)
              const Center(
                child: Text(
                  'Tap to choose!',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            TapCircle(taps: offsets, animationValue: animationController.value),
          ]),
        ),
      ),
    );
  }
}
