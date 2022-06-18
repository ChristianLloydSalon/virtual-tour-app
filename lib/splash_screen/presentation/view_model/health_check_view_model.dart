import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:virtual_tour_app/config/constants.dart';
import 'package:virtual_tour_app/splash_screen/di/health_check_service_locator.dart';
import 'package:virtual_tour_app/splash_screen/domain/model/heatlh_check_state.dart';
import 'package:virtual_tour_app/splash_screen/domain/repository/health_check_repository.dart';

import '../../domain/exception/unable_to_connect_exception.dart';

final healthCheckViewModel =
    StateNotifierProvider.autoDispose<HealthCheckViewModel, HealthCheckState>(
  (ref) => HealthCheckViewModel(healthCheckRepository),
);

class HealthCheckViewModel extends StateNotifier<HealthCheckState> {
  final HealthCheckRepository _repository;

  HealthCheckViewModel(this._repository) : super(const HealthCheckState()) {
    load();
  }

  Future<void> load() async {
    try {
      state = state.copyWith(status: HeatlhCheckStatus.loading);
      state = await _repository.getHealthCheck();
    } on Exception catch (error) {
      var errorMessage = kDefaultErrorMessage;

      if (error is UnableToConnectException) {
        errorMessage = error.toString();
      }

      state = state.copyWith(
        status: HeatlhCheckStatus.error,
        error: errorMessage,
      );
    }
  }
}
