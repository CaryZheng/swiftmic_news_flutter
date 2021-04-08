import 'package:flutter/material.dart';

class BodyPageView extends StatelessWidget {
  List<String> datas;
  PageController pageController;
  void Function(int) pageChangeCall;

  BodyPageView({this.datas, this.pageController, this.pageChangeCall});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: datas.length,
      onPageChanged: pageChangeCall,
      itemBuilder: (context, index) {
        String data = datas.elementAt(index);
        return Text("index = $index, datas = $data");
      },
    );
  }
}
