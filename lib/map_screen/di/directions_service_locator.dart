import 'package:virtual_tour_app/map_screen/data/repository/directions_repository_impl.dart';

import '../data/remote/directions_remote_source.dart';

final directionsRemoteSource = DirectionsRemoteSource();
final directionsRepository = DirectionsRepositoryImpl(directionsRemoteSource);
