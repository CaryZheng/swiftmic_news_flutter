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

  double _videoPlayPercent = 0;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
        "https://stream7.iqilu.com/10339/upload_transcode/202002/18/20200218114723HDu3hhxqIT.mp4")
      ..initialize().then((a) {
        setState(() {
          _controller.play();
        });
      });

    _controller.addListener(() {
      Duration duration = _controller.value.duration;
      int totalSeconds = duration.inSeconds;
      int currentSeconds = _controller.value.position.inSeconds;

      double percent = currentSeconds * 1.0 / totalSeconds;
      print(
          "Video currentSeconds = $currentSeconds, totalSeconds = $totalSeconds, percent = $percent");

      setState(() {
        _videoPlayPercent = percent;
      });
    });

    // _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: Image.asset(
                'images/z7.png',
                width: 30,
                height: 30,
              ),
              onPressed: () {
                print("导航栏菜单 clicked");
              }),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              SizedBox(height: 100),
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    Positioned(
                      bottom: 80,
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
                      bottom: 80,
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
                          height: 70,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 2,
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.grey[600],
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                  value: _videoPlayPercent,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0x88191919),
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "写跟贴",
                                    hintStyle: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0x88191919)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40.0),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0x88191919)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0x88191919)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
