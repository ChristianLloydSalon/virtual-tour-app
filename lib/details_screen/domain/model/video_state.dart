import 'package:equatable/equatable.dart';
import 'package:virtual_tour_app/details_screen/domain/model/video.dart';

enum VideoStatus {
  initial,
  loading,
  loaded,
  error,
}

class VideoState extends Equatable {
  final VideoStatus? status;
  final List<Video> items;
  final String? error;

  const VideoState({
    this.status,
    this.items = const [],
    this.error,
  });

  VideoState copyWith({
    VideoStatus? status,
    List<Video>? items,
    String? error,
  }) {
    return VideoState(
      status: status ?? this.status,
      items: items ?? this.items,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, items, error];
}
