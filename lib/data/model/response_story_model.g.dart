// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseStory _$ResponseStoryFromJson(Map<String, dynamic> json) =>
    ResponseStory(
      error: json['error'] as bool,
      message: json['message'] as String,
      listStory: (json['listStory'] as List<dynamic>?)
          ?.map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList(),
    );


Story _$StoryFromJson(Map<String, dynamic> json) => Story(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      photoUrl: json['photoUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'photoUrl': instance.photoUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'lat': instance.lat,
      'lon': instance.lon,
    };

DetailResponse _$DetailResponseFromJson(Map<String, dynamic> json) =>
    DetailResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
      story: json['story'] == null
          ? null
          : Story.fromJson(json['story'] as Map<String, dynamic>),
    );

