import 'package:story_apps/data/model/detail_story_model.dart';

class DetailStoryModel {
  bool error;
  String message;
  Story story;

  DetailStoryModel({
    required this.error,
    required this.message,
    required this.story,
  });

  factory DetailStoryModel.fromJson(Map<String, dynamic> json) =>
      DetailStoryModel(
        error: json["error"],
        message: json["message"],
        story: Story.fromJson(json["story"]),
      );
}
