import 'package:virtual_tour_app/home_screen/domain/model/tourist_spot.dart';

import '../../domain/repository/tourist_spot_repository.dart';
import '../remote/tourist_spot_remote_source.dart';

class TouristSpotRepositoryImpl implements TouristSpotRepository {
  final TouristSpotRemoteSource touristSpotRemoteSource;
  TouristSpotRepositoryImpl(this.touristSpotRemoteSource);

  @override
  Future<TouristSpot?> getTouristSpot(int id) async {
    return await touristSpotRemoteSource.getTouristSpot(id);
  }

  @override
  Future<List<TouristSpot>> getTouristSpots() async {
    return await touristSpotRemoteSource.getTouristSpots();
  }
}
