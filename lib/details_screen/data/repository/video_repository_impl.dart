import 'package:virtual_tour_app/details_screen/domain/model/video.dart';

import '../../domain/repository/video_repository.dart';
import '../remote/video_remote_source.dart';

class VideoRepositoryImpl extends VideoRepository {
  final VideoRemoteSource _videoRemoteSource;

  VideoRepositoryImpl(this._videoRemoteSource);

  @override
  Future<List<Video>> getVideos({required int touristSpotId}) async {
    return await _videoRemoteSource.getVideos(touristSpotId: touristSpotId);
  }
}
