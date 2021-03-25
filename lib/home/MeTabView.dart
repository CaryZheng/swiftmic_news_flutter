import 'package:flutter/material.dart';

class MeTabView extends StatefulWidget {
  final String _title;

  MeTabView(this._title);

  @override
  _MeTabViewState createState() => _MeTabViewState();
}

class _MeTabViewState extends State<MeTabView> {
  Widget buildNumberWithTextView(int number, String text) {
    return Container(
      child: Column(
        children: [
          Text(
            number.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIconWithTextView(String iconName, String text) {
    return Container(
      child: Column(
        children: [
          Text(
            iconName,
            style: TextStyle(
                fontFamily: "MaterialIcons", fontSize: 24, color: Colors.red),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // 动态生成菜单组
  Widget buildGroupMenu({List<String> titles, Function(int) onClicked}) {
    Column column = Column(
      children: [],
    );

    Container container = Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: column,
    );

    int index = 0;
    for (var title in titles) {
      final int currentIndex = index;
      Row row = Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
          Spacer(),
          Text(
            "\ue5b0",
            style: TextStyle(
              fontFamily: "MaterialIcons",
              fontSize: 24,
            ),
          ),
        ],
      );

      double marginTop = 0;
      if (0 == currentIndex) {
        marginTop = 0;
      } else {
        marginTop = 10;
      }

      var container = Container(
        child: row,
        margin: EdgeInsets.fromLTRB(0, marginTop, 0, 0),
      );

      InkWell inkWell = InkWell(
        child: container,
        onTap: () {
          onClicked(currentIndex);
        },
      );
      column.children.add(inkWell);

      if (titles.length > 1 && currentIndex < titles.length - 1) {
        Divider divider = Divider(
          height: 1,
          indent: 2,
          endIndent: 6,
        );

        Container dividerContainer = Container(
          child: divider,
          margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
        );

        column.children.add(dividerContainer);
      }

      index++;
    }

    return container;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(children: [
            Container(
              child: ClipOval(
                child: Image.asset(
                  'images/item_images_test.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.all(20),
            ),
            Column(
              children: [
                Text(
                  "CaryZheng",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ]),
          Row(children: [
            Expanded(
              child: buildNumberWithTextView(0, "动态"),
            ),
            Expanded(
              child: buildNumberWithTextView(1, "跟帖"),
            ),
            Expanded(
              child: buildNumberWithTextView(32, "收藏/推荐"),
            ),
            Expanded(
              child: buildNumberWithTextView(105813, "历史"),
            ),
          ]),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildIconWithTextView("\uE000", "我的关注"),
                buildIconWithTextView("\uE001", "我的圈子"),
                buildIconWithTextView("\uE002", "任务中心"),
                buildIconWithTextView("\uE003", "金币商城"),
              ],
            ),
          ),
          buildGroupMenu(
              titles: ["深色模式", "意见反馈", "我的会员"],
              onClicked: (int index) {
                print("a index = $index");
              }),
          buildGroupMenu(
              titles: ["用户鉴贴", "京东特供", "免流量看新闻"],
              onClicked: (int index) {
                print("b index = $index");
              }),
          buildGroupMenu(
              titles: ["我的已购", "我的钱包", "扫一扫"],
              onClicked: (int index) {
                print("c index = $index");
              }),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "~设置入口挪到页面顶部了哟~",
                style: TextStyle(fontSize: 13),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
