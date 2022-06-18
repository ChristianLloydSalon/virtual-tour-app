import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/constants.dart';

class SkeletonText extends StatelessWidget {
  final double width;
  final double height;

  const SkeletonText({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF6E7A84).withOpacity(0.15),
      highlightColor: const Color(0xFFFFFFFF).withOpacity(0.15),
      period: kShimmerPeriod,
      child: Container(
        width: width,
        height: height,
        color: const Color(0xFF1C1D20),
      ),
    );
  }
}
