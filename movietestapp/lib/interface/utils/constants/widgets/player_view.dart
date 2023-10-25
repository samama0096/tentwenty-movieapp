import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietestapp/interface/utils/constants/text_constants.dart';

import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({super.key, required this.url});
  final String url;
  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  YoutubePlayerController? _controller;
  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.url,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    _controller!.toggleFullScreenMode();
    print(_controller!.flags);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller == null
          ? const Material(
              child: Expanded(
                child: SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            )
          : YoutubePlayerBuilder(
              player: YoutubePlayer(
                onEnded: (data) {
                  //when trailer is ended, it navigates back after disposing controller
                  _controller!.toggleFullScreenMode();
                  Get.back();
                },
                controller: _controller!,
              ),
              builder: (context, player) {
                return Stack(
                  children: [
                    player,
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: MaterialButton(
                            shape: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            child: CustomText.smallText('Done'),
                            onPressed: () {
                              _controller!.toggleFullScreenMode();
                              Get.back();
                            }),
                      ),
                    )
                  ],
                );
              }),
    );
  }
}
