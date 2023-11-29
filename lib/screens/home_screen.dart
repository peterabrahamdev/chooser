import 'package:flutter/material.dart';
import 'package:random_chooser/providers/tap_location_provider.dart';
import 'package:random_chooser/widgets/tap_area.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    var tapCoordinates = ref.watch(tapCoordinatesProvider.notifier);
    var x = ref.watch(tapCoordinatesProvider)[0];
    var y = ref.watch(tapCoordinatesProvider)[1];
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        tapCoordinates.addCoordinates(
          renderBox.globalToLocal(details.globalPosition).dx,
          renderBox.globalToLocal(details.globalPosition).dy,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Random Chooser"),
        ),
        body: Column(
          children: [
            Text("${x.toStringAsFixed(2)} : ${y.toStringAsFixed(2)}"),
            TapArea(),
          ],
        ),
      ),
    );
  }
}
