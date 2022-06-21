import 'dart:convert';

import 'package:http_status_code/http_status_code.dart';
import 'package:virtual_tour_app/config/environment.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_tour_app/home_screen/domain/exception/no_tourist_spot_exception.dart';

import '../../../splash_screen/domain/exception/unable_to_connect_exception.dart';
import '../../domain/model/tourist_spot.dart';

class TouristSpotRemoteSource {
  final apiUrl = '${AppConfig.apiBaseUrl}/${ApiType.touristSpot.type}';

  Future<List<TouristSpot>> getTouristSpots() async {
    final url = Uri.parse('$apiUrl/all');
    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    );

    if (response.statusCode != StatusCode.OK) {
      throw UnableToConnectException();
    }

    final data = jsonDecode(response.body);
    return (data as List).map((e) => TouristSpot.fromJson(e)).toList();
  }

  Future<TouristSpot?> getTouristSpot(int id) async {
    final url = Uri.parse('$apiUrl/$id');
    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    );

    if (response.statusCode != StatusCode.OK) {
      throw UnableToConnectException();
    }

    if (response.body == 'null') {
      throw NoTouristSpotException();
    }

    final data = jsonDecode(response.body);
    return TouristSpot.fromJson(data);
  }
}
