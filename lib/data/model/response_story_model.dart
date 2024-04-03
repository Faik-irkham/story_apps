import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'response_story_model.g.dart';

ResponseStory storiesResponseFromJson(String str) =>
    ResponseStory.fromJson(json.decode(str));

@JsonSerializable()
class ResponseStory {
  final bool error;
  final String message;
  @JsonKey(name: "listStory")
  final List<Story>? listStory;

  ResponseStory({
    required this.error,
    required this.message,
    this.listStory,
  });

  factory ResponseStory.fromJson(Map<String, dynamic> json) =>
      _$ResponseStoryFromJson(json);
}

@JsonSerializable()
class Story {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final DateTime createdAt;
  final double? lat;
  final double? lon;

  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    this.lat,
    this.lon,
  });

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);
}

DetailResponse detailResponseFromJson(String str) =>
    DetailResponse.fromJson(json.decode(str));

@JsonSerializable()
class DetailResponse {
  final bool error;
  final String message;
  @JsonKey(name: "story")
  final Story? story;

  DetailResponse({
    required this.error,
    required this.message,
    this.story,
  });

  factory DetailResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailResponseFromJson(json);
}
