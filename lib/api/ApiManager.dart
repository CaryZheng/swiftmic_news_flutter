import 'package:http/http.dart' as http;
import 'dart:convert';

typedef OnNetworkCallback = void Function(String response, {String tag});

class ApiManager {
  /// 获取feed流数据（支持分页）
  void fetchFeedList(int startPageIndex, int pageSize,
      {tag: String, onNetworkCallback: OnNetworkCallback}) async {
    var url = Uri.parse(
        "https://easyqrcode-api.swiftmic.com/swiftmic/feed/list?startPage=${startPageIndex}&pageSize=${pageSize}");

    var response = await http.get(url);

    onNetworkCallback(utf8.decode(response.body.runes.toList()), tag: tag);
  }
}
