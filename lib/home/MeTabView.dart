import 'package:flutter/material.dart';

class MeTabView extends StatefulWidget {
  final String _title;

  MeTabView(this._title);

  @override
  _MeTabViewState createState() => _MeTabViewState();
}

class _MeTabViewState extends State<MeTabView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
    );
  }
}