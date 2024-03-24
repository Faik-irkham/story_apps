import 'package:flutter/material.dart';
import 'package:story_apps/data/preference/auth_preference.dart';

class CredentialProvider extends ChangeNotifier {
  AuthPreference preferences;

  CredentialProvider({required this.preferences}) {
    _getCredential();
  }

  String? _token;
  late String _name;
  late String _email;

  String? get token => _token;
  String get name => _name;
  String get email => _email;

  Future<void> _getCredential() async {
    _token = await preferences.getToken();
    _name = await preferences.getName();
    _email = await preferences.getEmail();
    notifyListeners();
  }

  Future<void> setCredential(String token, String name, String email) async {
    await preferences.setCredential(token, name, email);
    await _getCredential();
  }

  Future<void> deleteCredential() async {
    await preferences.deleteCredential();
    _token = '';
    _name = '';
    _email = '';
    notifyListeners();
  }
}
