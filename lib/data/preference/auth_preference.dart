import 'package:shared_preferences/shared_preferences.dart';

class AuthPreference {
  final Future<SharedPreferences> sharedPreferences;

  AuthPreference({required this.sharedPreferences});

  static const String _nameKey = 'name';
  static const String _emailKey = 'email';
  static const String _tokenKey = 'token';

  Future<String> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(_tokenKey) ?? '';
  }

  Future<String> getName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(_nameKey) ?? '';
  }

  Future<String> getEmail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(_emailKey) ?? '';
  }

  Future<void> setCredential(String token, String name, String email) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(_tokenKey, token);
    await pref.setString(_nameKey, name);
    await pref.setString(_emailKey, email);
  }

  Future<void> deleteCredential() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(_tokenKey);
    await pref.remove(_nameKey);
    await pref.remove(_emailKey);
  }
}
