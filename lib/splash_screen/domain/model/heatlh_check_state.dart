import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:virtual_tour_app/config/constants.dart';

enum HeatlhCheckStatus {
  initial,
  loading,
  loaded,
  error,
}

@immutable
class HealthCheckState extends Equatable {
  final HeatlhCheckStatus? status;
  final String? error;

  const HealthCheckState({
    this.status = HeatlhCheckStatus.initial,
    this.error = kDefaultErrorMessage,
  });

  HealthCheckState copyWith({
    HeatlhCheckStatus? status,
    String? error,
  }) {
    return HealthCheckState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
