import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:virtual_tour_app/config/constants.dart';
import 'package:virtual_tour_app/home_screen/domain/model/tourist_spot.dart';

enum TouristSpotStatus {
  initial,
  loading,
  loaded,
  error,
}

@immutable
class TouristSpotState extends Equatable {
  final TouristSpotStatus? status;
  final List<TouristSpot> items;
  final String? error;

  const TouristSpotState({
    this.status = TouristSpotStatus.initial,
    this.items = const [],
    this.error = kDefaultErrorMessage,
  });

  TouristSpotState copyWith({
    TouristSpotStatus? status,
    List<TouristSpot>? items,
    String? error,
  }) {
    return TouristSpotState(
      status: status ?? this.status,
      items: items ?? this.items,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        items,
        error,
      ];
}
