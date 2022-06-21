import 'package:virtual_tour_app/details_screen/domain/model/feature.dart';
import 'package:virtual_tour_app/details_screen/domain/model/feature_picture.dart';

import '../../domain/repository/features_repository.dart';
import '../remote/features_remote_source.dart';

class FeaturesRepositoryImpl implements FeaturesRepository {
  final FeaturesRemoteSource _featuresRemoteSource;

  FeaturesRepositoryImpl(this._featuresRemoteSource);

  @override
  Future<List<Feature>> getFeatures({required int touristSpotId}) async {
    return await _featuresRemoteSource.getFeatures(
      touristSpotId: touristSpotId,
    );
  }

  @override
  Future<List<FeaturePicture>> getFeaturePictures({
    required int touristSpotId,
    required int featureId,
  }) async {
    return await _featuresRemoteSource.getFeaturePictures(
      touristSpotId: touristSpotId,
      featureId: featureId,
    );
  }
}
