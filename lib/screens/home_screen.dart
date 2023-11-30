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
    var offset = ref.watch(tapCoordinatesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Chooser"),
      ),
      body: Stack(children: [
        GestureDetector(
          onTapDown: (TapDownDetails details) {
            tapCoordinates.addCoordinates(
              details.globalPosition,
            );
            print(details.globalPosition);
          },
          onTapUp: (TapUpDetails details) {
            tapCoordinates.addCoordinates(const Offset(0,0));
          },
          child: CustomPaint(
            size: Size.infinite,
            painter: TapCircle(
                offset,
                MediaQuery.of(context).padding.top +
                    AppBar().preferredSize.height),
          ),
        ),
      ]),
    );
  }
}
