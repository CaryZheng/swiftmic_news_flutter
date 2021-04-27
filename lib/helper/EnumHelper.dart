import 'package:swiftmic_news/feed/HomeFeedItemView.dart';
import 'package:swiftmic_news/topic/TopicRecommendItemType.dart';

class EnumHelper {
  static ItemType getItemType(String value) {
    if ("text_image" == value) {
      return ItemType.text_image;
    } else if ("video" == value) {
      return ItemType.video;
    }

    return ItemType.none;
  }

  static TopicRecommendItemType getTopicRecommendItemType(String value) {
    if ("text_image" == value) {
      return TopicRecommendItemType.text_image;
    } else if ("video" == value) {
      return TopicRecommendItemType.video;
    }

    return TopicRecommendItemType.none;
  }
}
