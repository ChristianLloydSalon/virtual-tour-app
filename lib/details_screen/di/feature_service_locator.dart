import 'package:virtual_tour_app/details_screen/data/remote/features_remote_source.dart';

import '../data/repository/features_repository_impl.dart';

final featuresRemoteSource = FeaturesRemoteSource();
final featuresRepository = FeaturesRepositoryImpl(featuresRemoteSource);
