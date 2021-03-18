import 'package:flutter/material.dart';
import 'package:swiftmic_news/home/FeedTabView.dart';
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
        primarySwatch: Colors.blue,
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("首页"),
        ),
        body: new TabBarView(controller: controller, children: pages),
        bottomNavigationBar: new Material(
          color: Colors.blue,
          child: new TabBar(
            controller: controller,
            tabs: <Tab>[
              new Tab(text: "首页", icon: new Icon(Icons.home)),
              new Tab(text: "视频", icon: new Icon(Icons.find_in_page)),
              new Tab(text: "圈子", icon: new Icon(Icons.message)),
              new Tab(text: "我的", icon: new Icon(Icons.person))
            ],
            indicatorWeight: 0.1,
          ),
        ),
      ),
    );
  }
}
