import 'package:flutter/material.dart';

class ArticleDetailPageView extends StatefulWidget {
  @override
  _ArticleDetailPageViewState createState() => _ArticleDetailPageViewState();
}

class _ArticleDetailPageViewState extends State<ArticleDetailPageView>
    with SingleTickerProviderStateMixin {
  final String sampleText = """
中国经济周刊-经济网讯 近日，山东省冠县人民法院在执行一起案件中，依法公开拍卖一个尾号为55555的手机号码，成交价高达120多万元。

该院执行法官赵天鹏表示，拍卖当天，经过85轮的竞价加价，这个手机号码最终以1203040元的价格成交。

“这个高价，在我们冠县、聊城市乃至山东省内，近年来都是非常少见的。”执行法官赵天鹏说，这个手机号码来自他们办理的一起黑社会性质组织犯罪案件。按照法律规定，扫黑除恶要“打财断血”。执行法官在对这起涉黑案件的涉财产部分进行执行时，线上线下全面调查，最终发现了这一个手机“靓号”。

“这个手机号虽然是无形的虚拟财产，但是具备一定的市场价值。于是，我们按照程序对这个手机号进行了委托评估，委托评估价格是53800元。”据赵天鹏法官介绍，该手机号从4.3万元起拍，经过一天的激烈竞价，最终被冠县当地的一名男士以120余万元的价格拍得，超出了评估价的22倍。

目前，竞买人已经按照公告时间将手机号的价款全部打入法院账户。按照法律规定，这个手机号的拍卖款项将依法上缴国库。目前，该院正积极协助竞买人办理手机号的相关过户手续。

对此，有网友说，“这尾号听上去有点委屈…… ”也有网友表示，千万别买这种号码，以前就有个看起来不错的号码，结果天天被骚扰，一天十几个电话，人都快炸了；还有网友发出质疑，“这号好吗？跟哭似的……”
  """;

  // bool _isShowCommentPageView = false;
  AnimationController _animationController;
  Animation<Offset> _animation;

  _ArticleDetailPageViewState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animationController.addStatusListener((status) {
      print("status = $status");
    });

    _animation = Tween(begin: Offset(1, 0), end: Offset(0, 0))
        .animate(_animationController);
  }

  Widget getBodyContentView() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "64位Chrome运行至少需8GB内存：安卓网友直呼用不起。64位Chrome运行至少需8GB内存：安卓网友直呼用不起。",
            style: TextStyle(fontSize: 20, color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              InkWell(
                child: ClipOval(
                  child: Image.asset(
                    'images/item_images_test.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                onTap: () {
                  _animationController.forward();
                  // setState(() {
                  //   _isShowCommentPageView = true;
                  // });
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "快科技",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          "57分钟前",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(" . "),
                        Text(
                          "快科技官方号",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
            child: Text(
              sampleText,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            margin: EdgeInsets.all(10)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text("帖子详情"),
            backgroundColor: Colors.red,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: getBodyContentView(),
                  ),
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    double dx = details.delta.dx;
                    print("dx = $dx");
                    if (dx < -15) {
                      _animationController.forward();

                      // setState(() {
                      //   _isShowCommentPageView = true;
                      // });
                    }
                  },
                  // onPanDown: (DragDownDetails e) {
                  //   print("GestureDetector onPanDown DragDownDetails = $e");
                  // },
                  // onPanUpdate: (DragUpdateDetails e) {
                  //   print("GestureDetector onPanUpdate DragUpdateDetails = $e");
                  // },
                  // onPanEnd: (DragEndDetails e) {
                  //   print("GestureDetector onPanUpdate DragEndDetails = $e");
                  // },
                ),
              ),
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 80,
                      height: 40,
                      child: Container(
                        child: TextField(
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: "写跟帖",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "\uE000",
                      style: TextStyle(
                          fontFamily: "MaterialIcons",
                          fontSize: 24,
                          color: Colors.red),
                    ),
                    Text(
                      "\uE000",
                      style: TextStyle(
                          fontFamily: "MaterialIcons",
                          fontSize: 24,
                          color: Colors.red),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
              ),
            ],
          ),
        ),
        SlideTransition(
          position: _animation,
          child: GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("评论详情"),
                  backgroundColor: Colors.red,
                  leading: InkWell(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () {
                      _animationController.reverse();

                      // setState(() {
                      //   _isShowCommentPageView = false;
                      // });
                    },
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Text("0-1234567890qwertyuiopasdfghjklzxcvbnm"),
                            Text("1-1234567890qwertyuiopasdfghjklzxcvbnm"),
                            Text("2-1234567890qwertyuiopasdfghjklzxcvbnm"),
                            Text("3-1234567890qwertyuiopasdfghjklzxcvbnm"),
                            Text("4-1234567890qwertyuiopasdfghjklzxcvbnm"),
                            Text("5-1234567890qwertyuiopasdfghjklzxcvbnm"),
                            Text("6-1234567890qwertyuiopasdfghjklzxcvbnm"),
                            Text("7-1234567890qwertyuiopasdfghjklzxcvbnm"),
                            Text("8-1234567890qwertyuiopasdfghjklzxcvbnm"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              double dx = details.delta.dx;
              print("CommentPageView dx = $dx");
              if (dx > 15) {
                _animationController.reverse();

                // setState(() {
                //   _isShowCommentPageView = false;
                // });
              }
            },
          ),
        ),
      ],
    );
  }
}
