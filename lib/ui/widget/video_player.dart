import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:netflix/utils/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String movieId;

  const VideoPlayer({Key? key, required this.movieId}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.movieId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        hideThumbnail: true,
      ),
    );
  }

  //****************************************************************************
  // Freeing the memory
  //****************************************************************************

  @override
  void dispose() {
    _youtubePlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _youtubePlayerController == null
        ? Center(
            child: SpinKitFadingCircle(
              color: kPrimaryColor,
              size: 20,
            ),
          )
        : YoutubePlayer(
            controller: _youtubePlayerController!,
            progressColors: ProgressBarColors(
              handleColor: kPrimaryColor,
              playedColor: kPrimaryColor,
            ),
            onEnded: (YoutubeMetaData meta) {
              _youtubePlayerController!.play();
              _youtubePlayerController!.pause();
            },
          );
  }
}
