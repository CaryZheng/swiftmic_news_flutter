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

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
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
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
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
    );
  }
}
