import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:virtual_tour_app/map_screen/domain/model/directions.dart';

abstract class DirectionsRepository {
  Future<Directions?> getDirections(
    LatLng origin,
    LatLng destination,
  );
}
