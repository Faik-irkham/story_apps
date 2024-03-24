import 'package:flutter/material.dart';
import 'package:story_apps/data/api/api_service.dart';
import 'package:story_apps/data/model/register_model.dart';
import 'package:story_apps/data/model/sign_in_model.dart';
import 'package:story_apps/data/model/sign_up_form_model.dart';
import 'package:story_apps/utils/response_state.dart';

class AuthProvider extends ChangeNotifier {
  ApiService apiService = ApiService();

  AuthProvider({required this.apiService});

  ResultState? _state;
  String _message = '';

  String get message => _message;
  ResultState? get state => _state;

  Future<RegisterModel> register(SignUpFormModel data) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.register(data);
      _state = ResultState.hasData;
      notifyListeners();
      return response;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      throw _message = 'Failed Register';
    }
  }

  Future<SignInModel> login(String email, String password) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.login(email, password);
      _state = ResultState.hasData;
      notifyListeners();
      return response;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      throw Exception('Failed login: $e');
    }
  }
}
