import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../config/constants.dart';
import '../../../home_screen/domain/exception/no_tourist_spot_exception.dart';
import '../../../splash_screen/domain/exception/unable_to_connect_exception.dart';
import '../../di/feature_service_locator.dart';
import '../../domain/model/feature_picture_state.dart';
import '../../domain/repository/features_repository.dart';

final featurePicturesViewModel = StateNotifierProvider.autoDispose
    .family<FeaturePicturesViewModel, FeaturePictureState, int>(
  (ref, id) => FeaturePicturesViewModel(featuresRepository, id),
);

class FeaturePicturesViewModel extends StateNotifier<FeaturePictureState> {
  final FeaturesRepository _repository;
  final int id;
  FeaturePicturesViewModel(
    this._repository,
    this.id,
  ) : super(const FeaturePictureState());

  void load(int featureId) async {
    try {
      state = state.copyWith(status: FeaturePictureStatus.loading);
      final items = await _repository.getFeaturePictures(
        touristSpotId: id,
        featureId: featureId,
      );
      state = state.copyWith(status: FeaturePictureStatus.loaded, items: items);
    } catch (error) {
      var errorMessage = kDefaultErrorMessage;

      if (error is UnableToConnectException ||
          error is NoTouristSpotException) {
        errorMessage = error.toString();
      }

      state = state.copyWith(
        status: FeaturePictureStatus.error,
        error: errorMessage,
      );
    }
  }
}
