import 'dart:convert';

import 'package:http_status_code/http_status_code.dart';
import 'package:virtual_tour_app/config/environment.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_tour_app/details_screen/domain/model/feature_picture.dart';

import '../../domain/model/feature.dart';

class FeaturesRemoteSource {
  final apiUrl = '${AppConfig.apiBaseUrl}/${ApiType.touristSpot.type}';

  Future<List<Feature>> getFeatures({required int touristSpotId}) async {
    final url = Uri.parse('$apiUrl/$touristSpotId/${ApiType.feature.type}/all');
    final response = await http.get(url);
    if (response.statusCode == StatusCode.OK) {
      final data = jsonDecode(response.body);
      return (data as List).map((e) => Feature.fromJson(e)).toList();
    }

    return [];
  }

  Future<List<FeaturePicture>> getFeaturePictures({
    required int touristSpotId,
    required int featureId,
  }) async {
    final url = Uri.parse(
      '$apiUrl/$touristSpotId/${ApiType.feature.type}/$featureId/pictures',
    );
    final response = await http.get(url);
    if (response.statusCode == StatusCode.OK) {
      final data = jsonDecode(response.body);
      return (data as List).map((e) => FeaturePicture.fromJson(e)).toList();
    }

    return [];
  }
}
