import 'dart:io';

import 'package:flutter/material.dart';
import 'package:story_apps/data/api/api_service.dart';
import 'package:story_apps/data/model/story_model.dart';
import 'package:story_apps/data/preference/auth_preference.dart';
import 'package:story_apps/utils/response_state.dart';

class StoryProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthPreference preferences;

  StoryProvider({required this.apiService, required this.preferences}) {
    fetchAllStory();
  }

  late StoryModel _storiesResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  StoryModel get result => _storiesResult;

  ResultState get state => _state;

  Future<dynamic> fetchAllStory() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final token = await preferences.getToken();
      final story = await apiService.getAllStories(token);
      if (story.listStory.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _storiesResult = story;
      }
    } catch (e) {
      if (e is SocketException) {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Tidak ada koneksi Internet!';
      } else {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Failed to Load Data';
      }
    }
  }
}
