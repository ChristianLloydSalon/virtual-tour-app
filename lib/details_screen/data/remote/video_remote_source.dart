import 'dart:convert';

import 'package:http_status_code/http_status_code.dart';
import 'package:virtual_tour_app/config/environment.dart';
import 'package:http/http.dart' as http;

import '../../domain/model/video.dart';

class VideoRemoteSource {
  final apiUrl = '${AppConfig.apiBaseUrl}/${ApiType.touristSpot.type}';

  Future<List<Video>> getVideos({required int touristSpotId}) async {
    final url = Uri.parse('$apiUrl/$touristSpotId/${ApiType.video.type}/all');
    print(url);
    final response = await http.get(url);
    if (response.statusCode == StatusCode.OK) {
      final data = jsonDecode(response.body);
      return (data as List).map((e) => Video.fromJson(e)).toList();
    }

    return [];
  }
}
