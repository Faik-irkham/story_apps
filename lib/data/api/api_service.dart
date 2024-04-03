import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:story_apps/data/model/register_model.dart';
import 'package:story_apps/data/model/response_story_model.dart';
import 'package:story_apps/data/model/sign_in_model.dart';
import 'package:story_apps/data/model/sign_up_form_model.dart';
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

  Future<ResponseStory> getAllStories(String token,
      [int page = 1, int size = 10]) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/stories?page=$page&size=$size'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return ResponseStory.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DetailResponse> getDetailStory(String token, String id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/stories/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return DetailResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get detail story: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get detail story: $e');
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

      request.fields['description'] = description;
      if (lat != null) request.fields['lat'] = lat.toString();
      if (lon != null) request.fields['lon'] = lon.toString();

      request.files.add(await http.MultipartFile.fromPath('photo', imagePath));

      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = 'Bearer $token';

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);

      return UploadModel.fromJson(jsonResponse);
    } catch (e) {
      throw Exception(e);
    }
  }
}
