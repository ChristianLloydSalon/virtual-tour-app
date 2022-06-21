import '../model/feature.dart';
import '../model/feature_picture.dart';

abstract class FeaturesRepository {
  Future<List<Feature>> getFeatures({required int touristSpotId});
  Future<List<FeaturePicture>> getFeaturePictures({
    required int touristSpotId,
    required int featureId,
  });
}
