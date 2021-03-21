import 'package:flutter/material.dart';
import 'package:swiftmic_news/feed/HomeFeedItemData.dart';

enum ItemType { none, text, text_images }

class HomeFeedItemView extends StatefulWidget {
  final HomeFeedItemData _data;

  HomeFeedItemView(this._data);

  @override
  _HomeFeedItemViewState createState() => _HomeFeedItemViewState();
}

class _HomeFeedItemViewState extends State<HomeFeedItemView> {
  @override
  Widget build(BuildContext context) {
    if (ItemType.text == widget._data.itemType) {
      print("build ItemType text");
      return getItemViewWithText();
    } else if (ItemType.text_images == widget._data.itemType) {
      print("build ItemType text_images");
      return getItemViewWithTextImages();
    }

    print("build ItemType none");
    return getItemViewWithText();
  }

  Widget getItemViewWithText() {
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

  Widget getItemViewWithTextImages() {
    return Container(
      child: Column(
        children: [
          Text(
            widget._data.title,
            style: TextStyle(fontSize: 18, color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'images/item_images_test.png',
                  width: 130,
                  height: 100,
                ),
                Image.asset(
                  'images/item_images_test.png',
                  width: 130,
                  height: 100,
                ),
                Image.asset(
                  'images/item_images_test.png',
                  width: 130,
                  height: 100,
                ),
              ],
            ),
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
