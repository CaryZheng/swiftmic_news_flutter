import 'package:flutter/material.dart';
import 'package:swiftmic_news/home/FeedTabView.dart';
import 'package:swiftmic_news/home/MainPage.dart';
import 'package:swiftmic_news/home/MeTabView.dart';
import 'package:swiftmic_news/home/MessageCenterTabView.dart';
import 'package:swiftmic_news/home/NodeTabView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  int _currentSelectedTabIndex = 0;

  final pages = [
    FeedTabView(),
    NodeTabView("视频"),
    MessageCenterTabView("圈子"),
    MeTabView("我的")
  ];

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        // appBar: new AppBar(
        //   title: new Text(
        //     "首页",
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   backgroundColor: Colors.white,
        // ),
        body: new TabBarView(
          controller: controller,
          children: pages,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: SafeArea(
            child: new Material(
              color: Colors.white,
              child: new TabBar(
                controller: controller,
                indicator: BoxDecoration(),
                labelColor: Colors.red,
                unselectedLabelColor: Colors.black54,
                indicatorColor: Colors.red,
                onTap: (int index) {
                  print("TabBar click index = $index");

                  setState(() {
                    _currentSelectedTabIndex = index;
                  });
                },
                tabs: <Tab>[
                  new Tab(
                    text: "首页",
                    icon: (0 == _currentSelectedTabIndex)
                        ? new Image.asset(
                            'images/afv.png',
                            width: 24,
                            height: 24,
                          )
                        : new Image.asset(
                            'images/aft.png',
                            width: 24,
                            height: 24,
                          ),
                  ),
                  new Tab(
                    text: "视频",
                    icon: (1 == _currentSelectedTabIndex)
                        ? new Image.asset(
                            'images/afz.png',
                            width: 24,
                            height: 24,
                          )
                        : new Image.asset(
                            'images/afy.png',
                            width: 24,
                            height: 24,
                          ),
                  ),
                  new Tab(
                    text: "圈子",
                    icon: (2 == _currentSelectedTabIndex)
                        ? new Image.asset(
                            'images/afq.png',
                            width: 24,
                            height: 24,
                          )
                        : Image.asset(
                            'images/afp.png',
                            width: 24,
                            height: 24,
                          ),
                  ),
                  new Tab(
                    text: "我的",
                    icon: (3 == _currentSelectedTabIndex)
                        ? new Image.asset(
                            'images/afx.png',
                            width: 24,
                            height: 24,
                          )
                        : Image.asset(
                            'images/afw.png',
                            width: 24,
                            height: 24,
                          ),
                  )
                ],
                indicatorWeight: 0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
