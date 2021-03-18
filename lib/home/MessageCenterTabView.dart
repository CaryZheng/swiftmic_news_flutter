import 'package:flutter/material.dart';

class MessageCenterTabView extends StatefulWidget {
  final String _title;

  MessageCenterTabView(this._title);

  @override
  _MessageCenterTabViewState createState() => _MessageCenterTabViewState();
}

class _MessageCenterTabViewState extends State<MessageCenterTabView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top view
        Flex(direction: Axis.horizontal,
            children: [
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
            ]
        ),
        // friend list view
        ListView(
          shrinkWrap: true,
          children: [
            Row(
                children: [
                  Container(height: 60, width: MediaQuery.of(context).size.width, color: Colors.orange,)
            ]),
            Row(
                children: [
                  Container(height: 60, width: MediaQuery.of(context).size.width, color: Colors.brown,)
                ]),
            Row(
                children: [
                  Container(height: 60, width: MediaQuery.of(context).size.width, color: Colors.purple,)
                ]),
            Row(
                children: [
                  Container(height: 60, width: MediaQuery.of(context).size.width, color: Colors.pink,)
                ]),
            Row(
                children: [
                  Container(height: 60, width: MediaQuery.of(context).size.width, color: Colors.yellow,)
                ]),
            Row(
                children: [
                  Container(height: 60, width: MediaQuery.of(context).size.width, color: Colors.cyan,)
                ]),
          ],
        )
      ],
    );
  }
}