import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:virtual_tour_app/home_screen/domain/exception/no_tourist_spot_exception.dart';
import 'package:virtual_tour_app/home_screen/domain/repository/tourist_spot_repository.dart';

import '../../../config/constants.dart';
import '../../../splash_screen/domain/exception/unable_to_connect_exception.dart';
import '../../di/tourist_spots_service_locator.dart';
import '../../domain/model/tourist_spot_state.dart';

final touristSpotsViewModel =
    StateNotifierProvider.autoDispose<TouristSpotsViewModel, TouristSpotState>(
  (ref) => TouristSpotsViewModel(touristSpotRepository),
);

class TouristSpotsViewModel extends StateNotifier<TouristSpotState> {
  final TouristSpotRepository _repository;
  TouristSpotsViewModel(this._repository) : super(const TouristSpotState()) {
    load();
  }

  void load() async {
    try {
      state = state.copyWith(status: TouristSpotStatus.loading);
      final items = await _repository.getTouristSpots();
      state = state.copyWith(status: TouristSpotStatus.loaded, items: items);
    } catch (error) {
      var errorMessage = kDefaultErrorMessage;

      if (error is UnableToConnectException ||
          error is NoTouristSpotException) {
        errorMessage = error.toString();
      }

      state = state.copyWith(
        status: TouristSpotStatus.error,
        error: errorMessage,
      );
    }
  }
}
