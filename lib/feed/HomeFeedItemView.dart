import 'package:flutter/material.dart';
import 'package:swiftmic_news/feed/HomeFeedItemData.dart';

typedef OnFeedItemClicked = void Function(HomeFeedItemData data);

enum ItemType {
  none,
  text_image,
  video,
}

class HomeFeedItemView extends StatefulWidget {
  final HomeFeedItemData _data;
  final OnFeedItemClicked onItemClicked;

  HomeFeedItemView(this._data, this.onItemClicked);

  @override
  _HomeFeedItemViewState createState() => _HomeFeedItemViewState();
}

class _HomeFeedItemViewState extends State<HomeFeedItemView> {
  @override
  Widget build(BuildContext context) {
    if (ItemType.text_image == widget._data.itemType) {
      print("build ItemType text_images");

      if (null == widget._data.images || widget._data.images.isEmpty) {
        return getItemViewWithText();
      } else if (widget._data.images.length >= 3) {
        return getItemViewWithTextImages();
      } else {
        return getItemViewWithTextImageOne();
      }
    } else if (ItemType.video == widget._data.itemType) {
      print("build ItemType video");
      return getItemViewWithVideo();
    }

    print("build ItemType none");
    return getItemViewWithText();
  }

  void onItemClicked() {
    if (null != widget.onItemClicked) {
      widget.onItemClicked(widget._data);
    }
  }

  Widget getItemViewWithText() {
    return InkWell(
      child: Container(
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
      ),
      onTap: () {
        onItemClicked();
      },
    );
  }

  Widget getItemViewWithTextImages() {
    double imageWidth =
        (MediaQuery.of(context).size.width - 10 * 2 - 4 * 10) / 3.0;
    double imageHeight = imageWidth * 0.8;

    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Text(
              widget._data.title,
              style: TextStyle(fontSize: 18, color: Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: "images/item_images_test.png",
                    image: widget._data.images[0],
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.cover,
                  ),
                  FadeInImage.assetNetwork(
                    placeholder: "images/item_images_test.png",
                    image: widget._data.images[1],
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.cover,
                  ),
                  FadeInImage.assetNetwork(
                    placeholder: "images/item_images_test.png",
                    image: widget._data.images[2],
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.cover,
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
      ),
      onTap: () {
        onItemClicked();
      },
    );
  }

  String _getFormatTimeWithSecondsMinute(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String getFormatVideoTime(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String result = _getFormatTimeWithSecondsMinute(duration);
    return result;
  }

  Widget getItemViewWithVideo() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    widget._data.title,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        FadeInImage.assetNetwork(
                          placeholder: "images/item_images_test.png",
                          image: widget._data.videoCover,
                          width: 130,
                          height: 104,
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'images/a_y.png',
                          width: 40,
                          height: 40,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 4, 4),
                      child: Text(
                        getFormatVideoTime(widget._data.videoTime),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
      ),
      onTap: () {
        onItemClicked();
      },
    );
  }

  Widget getItemViewWithTextImageOne() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    widget._data.title,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Stack(
                  children: [
                    FadeInImage.assetNetwork(
                      placeholder: "images/item_images_test.png",
                      image: widget._data.images.elementAt(0),
                      width: 130,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ],
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
      ),
      onTap: () {
        onItemClicked();
      },
    );
  }
}
