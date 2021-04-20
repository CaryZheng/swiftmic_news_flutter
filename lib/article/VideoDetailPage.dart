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
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    'images/a2w.png',
                    width: 30,
                    height: 30,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Image.asset(
                    'images/z7.png',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    Container(
                      child: FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (contex, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 100,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 60,
                        // height: 100,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: Image.asset(
                                      'images/item_images_test.png',
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "镜子里的世界",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                child: Text(
                                  "赵雷《我们的时光》又火了，比《成都》还抓耳，单曲循环停不下来",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 100,
                      child: Column(
                        children: [
                          Container(
                            child: ClipOval(
                              child: Image.asset(
                                'images/item_images_test.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            padding: EdgeInsets.all(10),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  child: ClipOval(
                                    child: Image.asset(
                                      'images/a61.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "1366",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  child: ClipOval(
                                    child: Image.asset(
                                      'images/a61.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  child: ClipOval(
                                    child: Image.asset(
                                      'images/aeq.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "296",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  child: ClipOval(
                                    child: Image.asset(
                                      'images/a56.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "分享",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("视频详情"),
    //     backgroundColor: Colors.red,
    //   ),
    //   body: Column(
    //     children: [
    //       Container(
    //         color: Colors.black,
    //         // child: _controller.value.isInitialized
    //         //     ? AspectRatio(
    //         //         aspectRatio: _controller.value.aspectRatio,
    //         //         child: VideoPlayer(_controller),
    //         //       )
    //         //     : Container(),

    //         child: FutureBuilder(
    //           future: _initializeVideoPlayerFuture,
    //           builder: (contex, snapshot) {
    //             if (snapshot.connectionState == ConnectionState.done) {
    //               return AspectRatio(
    //                 aspectRatio: _controller.value.aspectRatio,
    //                 child: VideoPlayer(_controller),
    //               );
    //             } else {
    //               return Center(child: CircularProgressIndicator());
    //             }
    //           },
    //         ),
    //         // AspectRatio(
    //         //   aspectRatio: _controller.value.aspectRatio,
    //         //   child: VideoPlayer(_controller),
    //         // ),
    //       ),
    //     ],
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       setState(() {
    //         if (_controller.value.isPlaying) {
    //           _controller.pause();
    //         } else {
    //           _controller.play();
    //         }
    //       });
    //     },
    //     child: Icon(
    //       _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //     ),
    //   ),
    // );
  }
}
