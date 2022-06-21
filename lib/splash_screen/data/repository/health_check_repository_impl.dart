import 'package:virtual_tour_app/splash_screen/data/remote/health_check_remote_source.dart';
import 'package:virtual_tour_app/splash_screen/domain/model/heatlh_check_state.dart';

import '../../domain/repository/health_check_repository.dart';

class HealthCheckRepositoryImpl extends HealthCheckRepository {
  final HealthCheckRemoteSource _remoteSource;

  HealthCheckRepositoryImpl(this._remoteSource);

  @override
  Future<HealthCheckState> getHealthCheck() async {
    return await _remoteSource.getHealthCheck();
  }
}
