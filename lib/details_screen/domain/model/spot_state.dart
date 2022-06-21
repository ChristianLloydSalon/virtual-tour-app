import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:virtual_tour_app/config/constants.dart';
import 'package:virtual_tour_app/home_screen/domain/model/tourist_spot.dart';

enum SpotStatus {
  initial,
  loading,
  loaded,
  error,
}

@immutable
class SpotState extends Equatable {
  final SpotStatus? status;
  final TouristSpot? item;
  final String? error;

  const SpotState({
    this.status = SpotStatus.initial,
    this.item,
    this.error = kDefaultErrorMessage,
  });

  SpotState copyWith({
    SpotStatus? status,
    TouristSpot? item,
    String? error,
  }) {
    return SpotState(
      status: status ?? this.status,
      item: item ?? this.item,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        item,
        error,
      ];
}
