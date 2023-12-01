import 'package:flutter/material.dart';
import 'package:random_chooser/providers/tap_location_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_chooser/widgets/tap_circle.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    var tapCoordinates = ref.watch(tapCoordinatesProvider.notifier);
    var offsets = ref.watch(tapCoordinatesProvider);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Random Chooser"),
      // ),
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

            tapCoordinates.addCoordinates(pointerId, Offset(x, y));
          },
          onPointerMove: (e) {
            int pointerId = e.pointer;
            double x = e.position.dx.round().toDouble();
            double y = (e.position.dy).round().toDouble();

            tapCoordinates.moveCoordinates(pointerId, Offset(x, y));
          },
          onPointerUp: (e) {
            int pointerId = e.pointer;
            double x = e.position.dx.round().toDouble();
            double y = (e.position.dy).round().toDouble();

            tapCoordinates.removeCoordinate(pointerId, Offset(x, y));
          },
          onPointerCancel: (e) {
            int pointerId = e.pointer;
            double x = e.position.dx.round().toDouble();
            double y = (e.position.dy).round().toDouble();

            tapCoordinates.removeCoordinate(pointerId, Offset(x, y));
          },
          child: CustomPaint(
            size: Size.infinite,
            painter: TapCircle(offsets, 0
                // MediaQuery.of(context).padding.top +
                //     AppBar().preferredSize.height
                ),
          ),
        ),
      ),
    );
  }
}
