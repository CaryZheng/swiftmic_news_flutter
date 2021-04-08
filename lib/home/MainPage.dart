// import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';

// class MainPage extends StatelessWidget {
//   static const _TITTLE_COUNT = 50;
//   List<WordPair> _tittles = <WordPair>[];
//   PageController _pageController = PageController();
//   void Function(int) pageCall;

//   //title设置回来的回调  当body页面变化时，会调用参数中的函数，将结果传递到title界面
//   void _pageChagedCall(void Function(int) call) {
//     this.pageCall = call;
//   }

//   //标题被点击时回调  滚动body页面
//   void _tittleItemClickCall(int pos) {
//     _pageController.animateToPage(pos,
//         duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
//   }

//   void _pageChage(int pos) {
//     if (pageCall != null) {
//       pageCall(pos);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     //准备数据源
//     _tittles.addAll(generateWordPairs().take(_TITTLE_COUNT));
//     return Scaffold(
//       appBar: AppBar(
//         //因为tittle准备放置一个listview，设置这个属性title横向填满
//         titleSpacing: 0.0,
//         title: TittlePage(
//           _tittles,
//           setCall: _pageChagedCall,
//           itemClick: _tittleItemClickCall,
//         ),
//       ),
//       body: BodyPage(
//         datas: _tittles,
//         controller: _pageController,
//         pageChageCall: _pageChage,
//       ),
//     );
//   }
// }

// class TittlePage extends StatefulWidget {
//   List<WordPair> datas;
//   void Function(void Function(int)) setCall;
//   void Function(int) itemClick;
//   TittlePage(this.datas, {this.setCall, this.itemClick});

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return TittlePageState(datas, setCall: setCall, itemClick: itemClick);
//   }
// }

// class TittlePageState extends State<TittlePage> {
//   List<WordPair> datas;
//   List<GlobalKey> keys = <GlobalKey>[];
//   ScrollController _controller = ScrollController();
//   void Function(void Function(int)) setCall;
//   void Function(int) itemClick;
//   int curItem = 0;

//   TittlePageState(this.datas, {this.setCall, this.itemClick}) {
//     setCall(bodyPageChange);
//     for (int i = 0; i < datas.length; i++) {
//       keys.add(GlobalKey(debugLabel: i.toString()));
//     }
//   }

//   /*
//   * 1,手动滑动body页面，触发这个函数
//   * 2，当点击title Item时，会调用itemClick，itemClick中会滚动body内容到指定页面，然后触发这个函数
//   * */
//   void bodyPageChange(int pos) {
//     setState(() {
//       curItem = pos;
//     });
//     scrollItemToCenter(pos);
//   }

//   //滚动Item到指定位置，这里滚动到屏幕正中间
//   void scrollItemToCenter(int pos) {
//     //获取item的尺寸和位置
//     RenderBox box = keys[pos].currentContext.findRenderObject();
//     Offset os = box.localToGlobal(Offset.zero);

// //    double h=box.size.height;
//     double w = box.size.width;
//     double x = os.dx;
// //    double y=os.dy;
// //   获取屏幕宽高
//     double windowW = MediaQuery.of(context).size.width;
// //    double windowH=MediaQuery.of(context).size.height;

//     //就算当前item距离屏幕中央的相对偏移量
//     double rlOffset = windowW / 2 - (x + w / 2);

//     //计算_controller应该滚动的偏移量
//     double offset = _controller.offset - rlOffset;
//     _controller.animateTo(offset,
//         duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
//   }

//   Widget initItemView(BuildContext context, WordPair pair, int pos) {
//     return Container(
//       //将key设置进去，后面通过key获取指定item的位置和尺寸
//       key: keys[pos],
//       padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
//       alignment: Alignment.bottomCenter,
//       child: InkWell(
//         onTap: () {
//           itemClick(pos);
//         },
//         child: Text(
//           pair.asPascalCase,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//               fontSize: 14,
//               color: curItem == pos ? Colors.white : Colors.black),
//         ),
//       ),
//     );
//   }

//   Widget initView() {
//     return Container(
//       height: 30,
//       child: ListView.builder(
//         controller: _controller,
//         scrollDirection: Axis.horizontal,
//         itemCount: datas.length,
//         itemBuilder: (context, pos) {
//           return initItemView(context, datas[pos], pos);
//         },
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return initView();
//   }
// }

// class BodyPage extends StatelessWidget {
//   List<WordPair> datas;
//   PageController controller;
//   void Function(int) pageChageCall;
//   BodyPage({this.datas, this.controller, this.pageChageCall});

//   Widget _buildItemPage(int pos) {
//     return Container(
//       alignment: Alignment.center,
//       child: Text(
//         datas[pos].asPascalCase,
//         textAlign: TextAlign.center,
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return PageView.builder(
//         controller: controller,
//         itemCount: datas.length,
//         onPageChanged: pageChageCall,
//         itemBuilder: (context, pos) {
//           return _buildItemPage(pos);
//         });
//   }
// }
