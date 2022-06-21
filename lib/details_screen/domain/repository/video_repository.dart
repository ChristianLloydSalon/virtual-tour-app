import 'package:virtual_tour_app/details_screen/domain/model/video.dart';

abstract class VideoRepository {
  Future<List<Video>> getVideos({required int touristSpotId});
}
