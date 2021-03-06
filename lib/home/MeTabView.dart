import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftmic_news/api/ApiManager.dart';
import 'package:swiftmic_news/helper/UserManager.dart';

class MeTabView extends StatefulWidget {
  final String _title;

  MeTabView(this._title);

  @override
  _MeTabViewState createState() => _MeTabViewState();
}

class _MeTabViewState extends State<MeTabView> {
  OverlayEntry _overlayEntry;
  double _tipViewHeight = 400;
  double _tipViewWidth = 300;
  Color testColor = Colors.grey;
  double _testViewHeight = 100;

  Color test2Color = Colors.red;

  Color test3Color = Color.fromRGBO(0, 0, 0, 1);

  bool _show = false;

  bool _isSignin = false;

  ApiManager _apiManager = new ApiManager();

  String _username = "";
  int _activityCount = 0;
  int _commentCount = 0;
  int _collectCount = 0;
  int _historyCount = 0;

  _MeTabViewState() {
    _isSignin = UserManager.getInstanse().isSignin();

    if (_isSignin) {
      _apiManager.fetchUserInfo(
          onNetworkCallback: (String response, {String tag}) {
        print("onNetworkCallback response = $response");

        Map<String, dynamic> responseBody = jsonDecode(response);
        int code = responseBody['code'];
        String message = responseBody['message'];

        print("code = $code");
        print("message = $message");

        Map data = responseBody['data'];
        String username = data["name"];
        int activityCount = data["activityCount"];
        int commentCount = data["commentCount"];
        int collectCount = data["collectCount"];
        int historyCount = data["historyCount"];

        setState(() {
          _username = username;
          _activityCount = activityCount;
          _commentCount = commentCount;
          _collectCount = collectCount;
          _historyCount = historyCount;
        });
      });
    }
  }

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
          Image.asset(
            iconName,
            width: 30,
            height: 30,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // ?????????????????????
  Widget buildGroupMenu({List<String> titles, Function(int) onClicked}) {
    Column column = Column(
      children: [],
    );

    Container container = Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
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
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
          Image.asset(
            "images/ah1.png",
            width: 20,
            height: 20,
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
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
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

  Widget buildSigninView() {
    return Row(
      children: [
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
              _username,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  Widget buildNoSigninView() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                side: BorderSide(width: 0.5, color: Colors.red),
                borderRadius: BorderRadius.circular(20)),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.red),
          padding: MaterialStateProperty.all(
            EdgeInsets.fromLTRB(50, 10, 50, 10),
          ),
        ),
        onPressed: () async {
          print("?????? btn clicked");
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          // String token = prefs.getString("token");
          // print("1 token = $token");

          UserManager.getInstanse().token = "poiqwer";

          prefs
              .setString("token", UserManager.getInstanse().token)
              .then((success) {
            print(
                "Save token local success = $success, token = ${UserManager.getInstanse().token}");
          });

          // String token2 = prefs.getString("token");
          // print("2 token = $token2");

          setState(() {
            _isSignin = true;
          });
        },
        child: Text(
          "??????",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget buildSigninCountView() {
    return Row(children: [
      Expanded(
        child: buildNumberWithTextView(_activityCount, "??????"),
      ),
      Expanded(
        child: buildNumberWithTextView(_commentCount, "??????"),
      ),
      Expanded(
        child: buildNumberWithTextView(_collectCount, "??????/??????"),
      ),
      Expanded(
        child: buildNumberWithTextView(_historyCount, "??????"),
      ),
    ]);
  }

  Widget buildNoSigninCountView() {
    return Row(children: [
      Expanded(
        child: buildNoSigninCountItemView("ah7", "??????"),
      ),
      Expanded(
        child: buildNoSigninCountItemView("aep", "??????"),
      ),
      Expanded(
        child: buildNoSigninCountItemView("agf", "??????/??????"),
      ),
      Expanded(
        child: buildNoSigninCountItemView("agi", "??????"),
      ),
    ]);
  }

  Widget buildNoSigninCountItemView(String iconName, String text) {
    return Container(
      child: Column(
        children: [
          Image.asset(
            'images/$iconName.png',
            width: 20,
            height: 20,
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
    return Container(
      color: Color(0xFFE9ECF0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/a6h.png',
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "??????",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/skin0_news_main_message_box_icon.png',
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "??????",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              _isSignin ? buildSigninView() : buildNoSigninView(),
              _isSignin ? buildSigninCountView() : buildNoSigninCountView(),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                padding: EdgeInsets.fromLTRB(10, 16, 10, 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildIconWithTextView("images/agg.png", "????????????"),
                    buildIconWithTextView("images/afq.png", "????????????"),
                    buildIconWithTextView("images/agj.png", "????????????"),
                    buildIconWithTextView("images/agh.png", "????????????"),
                  ],
                ),
              ),
              buildGroupMenu(
                  titles: ["????????????", "????????????", "????????????"],
                  onClicked: (int index) {
                    print("a index = $index");

                    if (0 == index) {
                      // AnimatedContainer container = AnimatedContainer(
                      //   duration: Duration(seconds: 3),
                      //   width: MediaQuery.of(context).size.width,
                      //   height: MediaQuery.of(context).size.height,
                      //   color: test3Color,
                      //   child: Column(
                      //     children: [
                      //       Expanded(
                      //         // flex: 1,
                      //         child: Container(),
                      //       ),
                      //       Container(
                      //         color: Colors.green,
                      //         width: MediaQuery.of(context).size.width,
                      //         child: Column(
                      //           children: [
                      //             Text("11111111111"),
                      //             ElevatedButton(
                      //               onPressed: () {
                      //                 // _overlayEntry.remove();

                      //                 setState(() {
                      //                   test3Color = Color.fromRGBO(0, 0, 0, 0.1);
                      //                 });
                      //               },
                      //               child: Text("Test"),
                      //             ),
                      //           ],
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // );

                      Container container = Container(
                        // duration: Duration(seconds: 3),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black,
                        child: Column(
                          children: [
                            Expanded(
                              // flex: 1,
                              child: Container(),
                            ),
                            Container(
                              color: Colors.green,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Text("11111111111"),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _show = !_show;
                                      });

                                      _overlayEntry.markNeedsBuild();

                                      Future.delayed(
                                          Duration(milliseconds: 300), () {
                                        _overlayEntry.remove();
                                      });
                                    },
                                    child: Text("Test"),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );

                      OverlayEntry overlayEntry = OverlayEntry(
                        builder: (context) => Positioned(
                          child: AnimatedOpacity(
                            opacity: _show ? 0.7 : 0,
                            duration: Duration(milliseconds: 200),
                            child: container,
                          ),
                        ),
                      );

                      _overlayEntry = overlayEntry;

                      Overlay.of(context).insert(overlayEntry);

                      Future.delayed(Duration(milliseconds: 100), () {
                        setState(() {
                          _show = true;
                        });
                        _overlayEntry.markNeedsBuild();
                      });
                    }
                  }),
              buildGroupMenu(
                  titles: ["????????????", "????????????", "??????????????????"],
                  onClicked: (int index) {
                    print("b index = $index");

                    setState(() {
                      if (100 == _testViewHeight) {
                        _testViewHeight = 200;
                        testColor = Colors.green;
                      } else {
                        _testViewHeight = 100;
                        testColor = Colors.grey;
                      }
                    });
                  }),
              buildGroupMenu(
                  titles: ["????????????", "????????????", "?????????"],
                  onClicked: (int index) {
                    print("c index = $index");
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "~????????????????????????????????????~",
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
        ),
      ),
    );
  }
}
