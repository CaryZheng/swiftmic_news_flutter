import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

typedef OnNetworkCallback = void Function(String response, {String tag});

class ApiManager {
  /// 获取feed流数据（支持分页）
  void fetchFeedList(int startPageIndex, int pageSize,
      {tag: "", onNetworkCallback: OnNetworkCallback}) async {
    var url = Uri.parse(
        "https://easyqrcode-api.swiftmic.com/swiftmic/feed/list?startPage=${startPageIndex}&pageSize=${pageSize}");

    var response = await http.get(url);

    onNetworkCallback(utf8.decode(response.body.runes.toList()), tag: tag);
  }

  Future<String> getJson(String name) {
    return rootBundle.loadString(name);
  }

  void fetchUserInfo({tag: "", onNetworkCallback: OnNetworkCallback}) async {
    await Future.delayed(Duration(milliseconds: 1000));

    String response = await getJson("json/user_info.json");
    onNetworkCallback(utf8.decode(response.runes.toList()), tag: tag);
  }

  void fetchFeedHeadList(int startPageIndex, int pageSize,
      {tag: "", onNetworkCallback: OnNetworkCallback}) async {
    await Future.delayed(Duration(milliseconds: 500));

    String response = await getJson("json/feeds_head.json");
    print("111 response = $response");
    onNetworkCallback(response, tag: tag);
    // onNetworkCallback(utf8.decode(response.runes.toList()), tag: tag);
  }
}
