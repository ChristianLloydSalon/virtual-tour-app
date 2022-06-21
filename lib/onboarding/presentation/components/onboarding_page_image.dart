import 'package:flutter/material.dart';

class OnBoardingPageImage extends StatelessWidget {
  final String image;

  const OnBoardingPageImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Image.asset(
          image,
          width: 150,
          height: 180,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
