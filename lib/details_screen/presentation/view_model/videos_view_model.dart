import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:virtual_tour_app/details_screen/di/video_service_locator.dart';
import 'package:virtual_tour_app/details_screen/domain/repository/video_repository.dart';

import '../../../config/constants.dart';
import '../../../home_screen/domain/exception/no_tourist_spot_exception.dart';
import '../../../splash_screen/domain/exception/unable_to_connect_exception.dart';
import '../../domain/model/video_state.dart';

final videosViewModel =
    StateNotifierProvider.autoDispose.family<VideosViewModel, VideoState, int>(
  (ref, id) => VideosViewModel(videoRepository, id),
);

class VideosViewModel extends StateNotifier<VideoState> {
  final VideoRepository _repository;
  final int id;
  VideosViewModel(
    this._repository,
    this.id,
  ) : super(const VideoState()) {
    load();
  }

  void load() async {
    try {
      state = state.copyWith(status: VideoStatus.loading);
      final items = await _repository.getVideos(touristSpotId: id);
      state = state.copyWith(status: VideoStatus.loaded, items: items);
    } catch (error) {
      var errorMessage = kDefaultErrorMessage;

      if (error is UnableToConnectException ||
          error is NoTouristSpotException) {
        errorMessage = error.toString();
      }

      state = state.copyWith(
        status: VideoStatus.error,
        error: errorMessage,
      );
    }
  }
}
