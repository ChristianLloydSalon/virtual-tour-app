import 'package:equatable/equatable.dart';
import 'package:virtual_tour_app/details_screen/domain/model/feature.dart';

enum FeatureStatus {
  initial,
  loading,
  loaded,
  error,
}

class FeatureState extends Equatable {
  final FeatureStatus? status;
  final List<Feature> items;
  final String? error;

  const FeatureState({
    this.status,
    this.items = const [],
    this.error,
  });

  FeatureState copyWith({
    FeatureStatus? status,
    List<Feature>? items,
    String? error,
  }) {
    return FeatureState(
      status: status ?? this.status,
      items: items ?? this.items,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, items, error];
}
