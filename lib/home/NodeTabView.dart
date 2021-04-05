import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      color: Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                print("http请求 btn clicked");
                fetchData();
              },
              child: Text("http请求"),
            ),
          ],
        ),
      ),
    );
  }

  void fetchData() async {
    var url = Uri.parse("https://easyqrcode-api.swiftmic.com/test");
    var response = await http.get(url);
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    Map<String, dynamic> responseBody = jsonDecode(response.body);
    int code = responseBody['code'];
    String message = responseBody['message'];
    Map<String, dynamic> data = responseBody['data'];
    String name = data['name'];
    int age = data['age'];

    print("code = ${code}");
    print("message = ${message}");

    print("data = ${data}");
    print("data name = ${name}");
    print("data age = ${age}");
  }
}
