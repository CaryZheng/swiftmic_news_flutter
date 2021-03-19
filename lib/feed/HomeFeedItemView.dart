import 'package:flutter/material.dart';
import 'package:swiftmic_news/feed/HomeFeedItemData.dart';

class HomeFeedItemView extends StatefulWidget {
  final HomeFeedItemData _data;

  HomeFeedItemView(this._data);

  @override
  _HomeFeedItemViewState createState() => _HomeFeedItemViewState();
}

class _HomeFeedItemViewState extends State<HomeFeedItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            widget._data.title,
            style: TextStyle(fontSize: 18, color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              // 作者
              Container(
                child: Text(
                  widget._data.authorName,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              ),
              Container(
                child: Text(
                  widget._data.commentCount.toString() + "跟帖",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                margin: EdgeInsets.fromLTRB(16, 10, 0, 0),
              )
            ],
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
    );
  }
}
