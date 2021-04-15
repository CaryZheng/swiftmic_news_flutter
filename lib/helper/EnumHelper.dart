import 'package:swiftmic_news/feed/HomeFeedItemView.dart';

class EnumHelper {
  static ItemType getItemType(String value) {
    if ("text_image" == value) {
      return ItemType.text_image;
    } else if ("video" == value) {
      return ItemType.video;
    }

    return ItemType.none;
  }
}
