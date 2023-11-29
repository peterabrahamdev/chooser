import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_chooser/providers/tap_location_provider.dart';
import 'package:random_chooser/widgets/tap_circle.dart';

class TapArea extends ConsumerStatefulWidget {
  const TapArea({super.key});

  @override
  ConsumerState<TapArea> createState() => _TapAreaState();
}

class _TapAreaState extends ConsumerState<TapArea> {
  @override
  Widget build(BuildContext context) {
    var offset = ref.watch(tapCoordinatesProvider);
    return CustomPaint(
      painter: TapCircle(offset),
    );
  }
}
