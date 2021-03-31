import 'package:http/http.dart' as http;
import 'dart:convert';

typedef OnNetworkCallback = void Function(String response, {String tag});

class ApiManager {
  void fetchFeedList(
      int startPage, int pageSize, OnNetworkCallback onNetworkCallback) async {
    var url = Uri.parse(
        "https://easyqrcode-api.swiftmic.com/swiftmic/feed/list?startPage=${startPage}&pageSize=${pageSize}");

    var response = await http.get(url);

    onNetworkCallback(utf8.decode(response.body.runes.toList()),
        tag: startPage.toString());
  }
}
