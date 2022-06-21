import 'package:flutter/material.dart';

class OnBoardingPageText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;

  const OnBoardingPageText({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle,
      ),
    );
  }
}
