import '../model/heatlh_check_state.dart';

abstract class HealthCheckRepository {
  Future<HealthCheckState> getHealthCheck();
}
