import '../data/remote/health_check_remote_source.dart';
import '../data/repository/health_check_repository_impl.dart';

final healthCheckRemoteSource = HealthCheckRemoteSource();
final healthCheckRepository = HealthCheckRepositoryImpl(
  healthCheckRemoteSource,
);
