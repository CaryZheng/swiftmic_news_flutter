import 'package:flutter/material.dart';

class MessageCenterTabView extends StatefulWidget {
  final String _title;

  MessageCenterTabView(this._title);

  @override
  _MessageCenterTabViewState createState() => _MessageCenterTabViewState();
}

class _MessageCenterTabViewState extends State<MessageCenterTabView> {
  /// 自定义顶部标题栏
  Widget buildCustomTitleView() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "推荐",
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(
            width: 40,
          ),
          Text(
            "广场",
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            buildCustomTitleView(),
            // Top view
            Flex(direction: Axis.horizontal, children: [
              // 评论item
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 100,
                    color: Colors.red,
                  )),
              // 点赞item
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 100,
                    color: Colors.yellow,
                  )),
              // 回答item
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 100,
                    color: Colors.brown,
                  )),
              // 收藏item
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 100,
                    color: Colors.purple,
                  ))
            ]),
            // friend list view
            ListView(
              shrinkWrap: true,
              children: [
                Row(children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.orange,
                  )
                ]),
                Row(children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.brown,
                  )
                ]),
                Row(children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.purple,
                  )
                ]),
                Row(children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.pink,
                  )
                ]),
                Row(children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.yellow,
                  )
                ]),
                Row(children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.cyan,
                  )
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
