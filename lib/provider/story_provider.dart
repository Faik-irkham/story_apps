import 'dart:io';

import 'package:flutter/material.dart';
import 'package:story_apps/data/api/api_service.dart';
import 'package:story_apps/data/model/response_story_model.dart';
import 'package:story_apps/data/model/upload_response.dart';
import 'package:story_apps/data/preference/auth_preference.dart';
import 'package:story_apps/utils/response_state.dart';

class StoryProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthPreference preferences;

  StoryProvider({required this.apiService, required this.preferences}) {
    getAllStory();
  }

  List<Story> allStory = [];
  List<Story>? _listStory;
  Story? _detailStory;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  List<Story>? get listStory => _listStory;
  Story? get story => _detailStory;

  ResultState get state => _state;
  int? pageItems = 1;
  int sizeItems = 10;

  Future<dynamic> getAllStory() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final token = await preferences.getToken();
      final response =
          await apiService.getAllStories(token, pageItems!, sizeItems);
      if (response.error == false) {
        List<Story> data = response.listStory!;
        allStory.addAll(data);
        if (data.length < sizeItems) {
          pageItems = null;
        } else {
          pageItems = pageItems! + 1;
        }
      }
      _state = ResultState.done;
      notifyListeners();
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

  Future<void> detailStory(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final token = await preferences.getToken();
      final response = await apiService.getDetailStory(token, id);

      if (!response.error) {
        _detailStory = response.story;
        _state = ResultState.done; // Ubah status menjadi done saat berhasil
      } else {
        _state = ResultState.error;
      }

      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      throw Exception('Failed fetch data: $e');
    }
  }

  Future<UploadModel> postStory({
    required String token,
    required String description,
    required String imagePath,
    double? lat,
    double? lon,
  }) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.uploadStory(
        token,
        description,
        imagePath,
        lat,
        lon,
      );
      _state = ResultState.done;
      notifyListeners();
      return response;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      throw Exception('Failed upload: $e');
    }
  }

  Future<void> refresh() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      await getAllStory();
      _state = ResultState.done;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      throw Exception('Failed to refresh data: $e');
    }
  }
}
