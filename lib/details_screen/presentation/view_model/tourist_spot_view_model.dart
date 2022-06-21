import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../config/constants.dart';
import '../../../home_screen/di/tourist_spots_service_locator.dart';
import '../../../home_screen/domain/exception/no_tourist_spot_exception.dart';
import '../../../home_screen/domain/repository/tourist_spot_repository.dart';
import '../../../splash_screen/domain/exception/unable_to_connect_exception.dart';
import '../../domain/model/spot_state.dart';

final touristSpotViewModel = StateNotifierProvider.autoDispose
    .family<TouristSpotViewModel, SpotState, int>(
  (ref, id) => TouristSpotViewModel(touristSpotRepository, id),
);

class TouristSpotViewModel extends StateNotifier<SpotState> {
  final TouristSpotRepository _repository;
  final int id;
  TouristSpotViewModel(
    this._repository,
    this.id,
  ) : super(const SpotState()) {
    load();
  }

  void load() async {
    try {
      state = state.copyWith(status: SpotStatus.loading);
      final item = await _repository.getTouristSpot(id);
      state = state.copyWith(status: SpotStatus.loaded, item: item);
    } catch (error) {
      var errorMessage = kDefaultErrorMessage;

      if (error is UnableToConnectException ||
          error is NoTouristSpotException) {
        errorMessage = error.toString();
      }

      state = state.copyWith(
        status: SpotStatus.error,
        error: errorMessage,
      );
    }
  }
}
