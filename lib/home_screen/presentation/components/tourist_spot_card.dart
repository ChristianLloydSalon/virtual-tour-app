import 'package:flutter/material.dart';
import 'package:virtual_tour_app/home_screen/domain/model/tourist_spot.dart';
import 'package:virtual_tour_app/map_screen/presentation/components/image_network.dart';

class TouristSpotCard extends StatelessWidget {
  final TouristSpot spot;
  final double width;
  final double height;
  const TouristSpotCard({
    Key? key,
    required this.spot,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            child: ImageNetwork(
              url: spot.image,
              width: width,
              height: height,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: width,
              height: height * 0.33,
              color: Colors.white38,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  spot.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
