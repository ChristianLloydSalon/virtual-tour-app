import 'package:virtual_tour_app/home_screen/data/repository/tourist_spot_repository_impl.dart';

import '../data/remote/tourist_spot_remote_source.dart';

final touristSpotRemoteSource = TouristSpotRemoteSource();
final touristSpotRepository =
    TouristSpotRepositoryImpl(touristSpotRemoteSource);
