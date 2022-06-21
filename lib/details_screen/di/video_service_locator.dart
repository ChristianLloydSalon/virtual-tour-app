import '../data/remote/video_remote_source.dart';
import '../data/repository/video_repository_impl.dart';

final videoRemoteSource = VideoRemoteSource();
final videoRepository = VideoRepositoryImpl(videoRemoteSource);
