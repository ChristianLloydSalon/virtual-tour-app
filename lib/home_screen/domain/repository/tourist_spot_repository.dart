import '../model/tourist_spot.dart';

abstract class TouristSpotRepository {
  Future<List<TouristSpot>> getTouristSpots();
  Future<TouristSpot?> getTouristSpot(int id);
}
