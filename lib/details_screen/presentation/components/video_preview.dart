import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:virtual_tour_app/common/components/skeleton.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPreview extends StatefulWidget {
  final String videoUrl;
  const VideoPreview({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..setLooping(true)
      ..initialize().then(
        (_) {
          setState(() {});
        },
      );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(widget),
      onVisibilityChanged: (visibilityInfo) {
        if (_controller.value.isInitialized) {
          if (visibilityInfo.visibleFraction > 0.5) {
            _controller.play();
          } else {
            _controller.pause();
          }
        }
      },
      child: _controller.value.isInitialized
          ? Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_controller.value.isPlaying) {
                          setState(() {
                            _controller.pause();
                          });
                        } else {
                          setState(() {
                            _controller.play();
                          });
                        }
                      },
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SkeletonText(width: 100, height: 100),
    );
  }
}
