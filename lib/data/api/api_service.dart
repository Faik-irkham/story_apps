import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:story_apps/data/model/register_model.dart';
import 'package:story_apps/data/model/sign_in_model.dart';
import 'package:story_apps/data/model/sign_up_form_model.dart';
import 'package:story_apps/data/model/story_model.dart';

class ApiService {
  static const String _baseUrl = 'https://story-api.dicoding.dev/v1';

  Future<RegisterModel> register(SignUpFormModel data) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        body: data.toJson(),
      );
      final register = RegisterModel.fromJson(jsonDecode(response.body));
      return register;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<SignInModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      return SignInModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login Gagal');
    }
  }

  Future<StoryModel> getAllStories(String token) async {

    final response = await http.get(
      Uri.parse('$_baseUrl/stories'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return StoryModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load story');
    }
  }
}
