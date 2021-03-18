import 'package:flutter/material.dart';

class NodeTabView extends StatefulWidget {
  final String _title;

  NodeTabView(this._title);

  @override
  _NodeTabViewState createState() => _NodeTabViewState();
}

class _NodeTabViewState extends State<NodeTabView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(widget._title)),
    );
  }
}
