import 'package:swiftmic_news/topic/TopicRecommendItemType.dart';

class TopicRecommendItemData {
  TopicRecommendItemType itemType; // 类型

  String avatarUrl;
  String authorName; // 作者
  String authorDescription; // 作者描述

  String textContent; // 内容
  List<String> images; // 图片

  int commentCount; // 跟帖数

  String videoCover; // 视频封面
  int videoTime; // 视频时长

  int upCount; // 点赞数
  int downCount; // 点踩数
}
