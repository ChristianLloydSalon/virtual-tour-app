import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:virtual_tour_app/details_screen/di/feature_service_locator.dart';
import 'package:virtual_tour_app/details_screen/domain/repository/features_repository.dart';

import '../../../config/constants.dart';
import '../../../home_screen/domain/exception/no_tourist_spot_exception.dart';
import '../../../splash_screen/domain/exception/unable_to_connect_exception.dart';
import '../../domain/model/feature_state.dart';

final featuresViewModel = StateNotifierProvider.autoDispose
    .family<FeaturesViewModel, FeatureState, int>(
  (ref, id) => FeaturesViewModel(featuresRepository, id),
);

class FeaturesViewModel extends StateNotifier<FeatureState> {
  final FeaturesRepository _repository;
  final int id;
  FeaturesViewModel(
    this._repository,
    this.id,
  ) : super(const FeatureState()) {
    load();
  }

  void load() async {
    try {
      state = state.copyWith(status: FeatureStatus.loading);
      final items = await _repository.getFeatures(touristSpotId: id);
      state = state.copyWith(status: FeatureStatus.loaded, items: items);
    } catch (error) {
      var errorMessage = kDefaultErrorMessage;

      if (error is UnableToConnectException ||
          error is NoTouristSpotException) {
        errorMessage = error.toString();
      }

      state = state.copyWith(
        status: FeatureStatus.error,
        error: errorMessage,
      );
    }
  }
}
