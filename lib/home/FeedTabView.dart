import 'package:flutter/material.dart';
import 'package:swiftmic_news/article/ArticleDetailPageView.dart';

class FeedTabView extends StatefulWidget {
  @override
  _FeedTabViewState createState() => _FeedTabViewState();
}

class _FeedTabViewState extends State<FeedTabView> {
  @override
  Widget build(BuildContext context) {
    return buildListView();
  }

  Widget buildListView() {
    return ListView.builder(itemBuilder: (context, i) {
      return buildRow(i);
    });
  }

  Widget buildRow(int index) {
    return ListTile(
      title: Text("index: " + index.toString()),
      onTap: onItemClicked,
    );
  }

  void onItemClicked() {
    print("onItemClicked");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ArticleDetailPageView()),
    );
  }
}
