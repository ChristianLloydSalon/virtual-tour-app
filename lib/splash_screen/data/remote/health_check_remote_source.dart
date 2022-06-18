import 'package:http_status_code/http_status_code.dart';
import 'package:virtual_tour_app/splash_screen/domain/exception/unable_to_connect_exception.dart';
import 'package:virtual_tour_app/splash_screen/domain/model/heatlh_check_state.dart';
import 'package:http/http.dart' as http;

import '../../../config/environment.dart';

class HealthCheckRemoteSource {
  final apiUrl = '${AppConfig.apiBaseUrl}/${ApiType.health.type}';

  Future<HealthCheckState> getHealthCheck() async {
    final url = Uri.parse(apiUrl);
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

    return const HealthCheckState(
      status: HeatlhCheckStatus.loaded,
    );
  }
}
