import 'package:equatable/equatable.dart';
import 'package:virtual_tour_app/details_screen/domain/model/feature_picture.dart';

enum FeaturePictureStatus {
  initial,
  loading,
  loaded,
  error,
}

class FeaturePictureState extends Equatable {
  final FeaturePictureStatus? status;
  final List<FeaturePicture> items;
  final String? error;

  const FeaturePictureState({
    this.status,
    this.items = const [],
    this.error,
  });

  FeaturePictureState copyWith({
    FeaturePictureStatus? status,
    List<FeaturePicture>? items,
    String? error,
  }) {
    return FeaturePictureState(
      status: status ?? this.status,
      items: items ?? this.items,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, items, error];
}
