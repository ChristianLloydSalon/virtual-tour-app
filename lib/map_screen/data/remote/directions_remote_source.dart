import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:virtual_tour_app/config/environment.dart';
import 'package:virtual_tour_app/map_screen/domain/exception/unable_to_parse_exception.dart';
import 'package:virtual_tour_app/map_screen/domain/model/directions.dart';

class DirectionsRemoteSource {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json';

  final Dio _dio = Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': AppConfig.googleMapsApi,
      },
    );

    if (response.statusCode != StatusCode.OK) {
      throw UnableToParseException();
    }

    if (response.data == null) {
      throw UnableToParseException();
    }

    return Directions.fromJson(response.data);
  }
}
