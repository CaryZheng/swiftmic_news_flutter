import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VideoDetailPageState();
  }
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  bool isTest = false;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        'https://stream7.iqilu.com/10339/upload_transcode/202002/18/20200218114723HDu3hhxqIT.mp4');

    _initializeVideoPlayerFuture = _controller.initialize();

    // _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("视频详情"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Container(
            // child: _controller.value.isInitialized
            //     ? AspectRatio(
            //         aspectRatio: _controller.value.aspectRatio,
            //         child: VideoPlayer(_controller),
            //       )
            //     : Container(),

            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (contex, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            // AspectRatio(
            //   aspectRatio: _controller.value.aspectRatio,
            //   child: VideoPlayer(_controller),
            // ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
