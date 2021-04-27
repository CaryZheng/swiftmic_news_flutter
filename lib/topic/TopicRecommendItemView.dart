import 'package:flutter/material.dart';
import 'package:swiftmic_news/topic/TopicRecommendItemData.dart';
import 'package:swiftmic_news/topic/TopicRecommendItemType.dart';

class TopicRecommendItemView extends StatefulWidget {
  final TopicRecommendItemData data;
  final void Function(TopicRecommendItemData data) onItemClicked;

  TopicRecommendItemView(this.data, this.onItemClicked);

  @override
  State<StatefulWidget> createState() {
    return _TopicRecommendItemViewState();
  }
}

class _TopicRecommendItemViewState extends State<TopicRecommendItemView> {
  void onItemClicked() {
    if (null != widget.onItemClicked) {
      widget.onItemClicked(widget.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return getItemViewWithTextImageOne();

    // if (TopicRecommendItemType.text_image == widget.data.itemType) {
    //   print("build ItemType text_images");

    //   if (null == widget.data.images || widget.data.images.isEmpty) {
    //     // return getItemViewWithText();
    //   } else if (widget.data.images.length >= 3) {
    //     // return getItemViewWithTextImages();
    //   } else {
    //     return getItemViewWithTextImageOne();
    //   }
    // }

    // print("build ItemType none");
    // return getItemViewWithText();
  }

  Widget getItemViewWithTextImageOne() {
    final double imageWidth = 110;
    final double imageHeight = imageWidth * 0.75;

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
                ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder: "images/item_images_test.png",
                    image: widget.data.avatarUrl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.authorName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.data.authorDescription,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: imageHeight,
                    child: Text(
                      widget.data.textContent,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: "images/item_images_test.png",
                    image: widget.data.images[0],
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/aes.png",
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(width: 6),
                          Text("分享"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/aep.png",
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 6),
                        Text("1"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/a7k.png",
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 6),
                        Text("2"),
                        SizedBox(width: 6),
                        Image.asset(
                          "images/a7j.png",
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
