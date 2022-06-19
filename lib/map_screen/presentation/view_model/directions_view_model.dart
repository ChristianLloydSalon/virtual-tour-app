import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:virtual_tour_app/map_screen/di/directions_service_locator.dart';

import '../../domain/model/directions_state.dart';
import '../../domain/repository/directions_repository.dart';

final directionsViewModel =
    StateNotifierProvider.autoDispose<DirectionsViewModel, DirectionsState>(
  (ref) => DirectionsViewModel(directionsRepository),
);

class DirectionsViewModel extends StateNotifier<DirectionsState> {
  final DirectionsRepository _repository;

  DirectionsViewModel(this._repository) : super(const DirectionsState());

  void reset() {
    state = const DirectionsState();
  }

  Future<void> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      state = state.copyWith(status: DirectionsStatus.loading, origin: origin);

      final directions = await _repository.getDirections(
        origin,
        destination,
      );

      state = state.copyWith(
        status: DirectionsStatus.loaded,
        origin: origin,
        distance: directions?.totalDistance,
        duration: directions?.totalDuration,
        polylinePoints: {
          Polyline(
            polylineId: const PolylineId('overview_polyline'),
            color: Colors.red,
            width: 5,
            points: directions!.polylinePoints
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
          )
        },
      );
    } on Exception catch (error) {
      state = state.copyWith(error: error.toString());
    }
  }
}
