import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:story_apps/data/model/register_model.dart';
import 'package:story_apps/data/model/response_detail.dart';
import 'package:story_apps/data/model/sign_in_model.dart';
import 'package:story_apps/data/model/sign_up_form_model.dart';
import 'package:story_apps/data/model/story_model.dart';
import 'package:story_apps/data/model/upload_response.dart';

class ApiService {
  static const String _baseUrl = 'https://story-api.dicoding.dev/v1';

  Future<RegisterModel> register(SignUpFormModel data) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        body: data.toJson(),
      );
      return RegisterModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<SignInModel> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        body: {
          'email': email,
          'password': password,
        },
      );
      return SignInModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<StoryModel> getAllStories(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/stories'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return StoryModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DetailStoryModel> getDetailStory(String token, String id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/stories/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return DetailStoryModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UploadModel> uploadStory(
    String token,
    String description,
    String imagePath,
    double? lat,
    double? lon,
  ) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/stories'),
      );
      // Add form fields
      request.fields['description'] = description;
      if (lat != null) request.fields['lat'] = lat.toString();
      if (lon != null) request.fields['lon'] = lon.toString();

      // Add file
      request.files.add(await http.MultipartFile.fromPath('photo', imagePath));

      // Add headers
      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = 'Bearer $token';

      // Send request
      var response = await request.send();
      // Get response
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);

      return UploadModel.fromJson(jsonResponse);
    } catch (e) {
      throw Exception(e);
    }
  }
}
