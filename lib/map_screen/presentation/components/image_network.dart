import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:virtual_tour_app/common/components/skeleton.dart';

class ImageNetwork extends HookWidget {
  final String url;
  final double width;
  final double height;
  const ImageNetwork({
    Key? key,
    required this.url,
    this.width = 50,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.white30,
      child: Image.network(
        url,
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return SkeletonText(width: width, height: height);
        },
      ),
    );
  }
}
