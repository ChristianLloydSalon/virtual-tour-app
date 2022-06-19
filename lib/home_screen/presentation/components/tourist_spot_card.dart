import 'package:flutter/material.dart';

class TouristSpotCard extends StatelessWidget {
  final String imageUrl;
  const TouristSpotCard({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Image.network(
        imageUrl,
        fit: BoxFit.fill,
      ),
    );
  }
}
