import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:virtual_tour_app/map_screen/data/remote/directions_remote_source.dart';
import 'package:virtual_tour_app/map_screen/domain/model/directions.dart';

import '../../domain/repository/directions_repository.dart';

class DirectionsRepositoryImpl extends DirectionsRepository {
  final DirectionsRemoteSource _remoteSource;
  DirectionsRepositoryImpl(this._remoteSource);

  @override
  Future<Directions?> getDirections(LatLng origin, LatLng destination) async {
    return _remoteSource.getDirections(
      origin: origin,
      destination: destination,
    );
  }
}
