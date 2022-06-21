import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoadingIndicator extends HookWidget {
  final double width;
  final double height;
  const CustomLoadingIndicator({
    Key? key,
    this.width = 50,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 50,
      height: 50,
      child: LoadingIndicator(
        indicatorType: Indicator.lineScale,
        colors: [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
        ],
        strokeWidth: 2,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
