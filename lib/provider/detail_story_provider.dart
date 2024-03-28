import 'package:flutter/material.dart';
import 'package:story_apps/data/api/api_service.dart';

class DetailStoryProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailStoryProvider({required this.apiService});
}
