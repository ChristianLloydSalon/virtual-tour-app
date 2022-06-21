import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum DirectionsStatus {
  initial,
  loading,
  loaded,
  error,
}

@immutable
class DirectionsState extends Equatable {
  final DirectionsStatus? status;
  final String? distance;
  final String? duration;
  final Set<Polyline> polylinePoints;
  final String? error;
  final LatLng? origin;

  const DirectionsState({
    this.status = DirectionsStatus.initial,
    this.distance,
    this.duration,
    this.polylinePoints = const {},
    this.error,
    this.origin,
  });

  DirectionsState copyWith({
    DirectionsStatus? status,
    String? distance,
    String? duration,
    Set<Polyline>? polylinePoints,
    String? error,
    LatLng? origin,
  }) {
    return DirectionsState(
      status: status ?? this.status,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      polylinePoints: polylinePoints ?? this.polylinePoints,
      error: error ?? this.error,
      origin: origin ?? this.origin,
    );
  }

  @override
  List<Object?> get props => [
        status,
        distance,
        duration,
        polylinePoints,
        error,
        origin,
      ];
}
