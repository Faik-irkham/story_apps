import 'list_story_model.dart';

class StoryModel {
  final bool error;
  final String message;
  final List<ListStoryModel> listStory;

  StoryModel({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        error: json["error"],
        message: json["message"],
        listStory: List<ListStoryModel>.from((json["listStory"] as List)
            .map((x) => ListStoryModel.fromJson(x))
            .where((story) =>
                story.id != null &&
                story.name != null &&
                story.photoUrl != null &&
                story.createdAt != null)),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "listStory": List<dynamic>.from(listStory.map((x) => x.toJson())),
      };
}
