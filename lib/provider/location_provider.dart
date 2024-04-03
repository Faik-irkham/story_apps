import 'dart:io';

import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  double? _selectedLat;
  double? _selectedLon;

  File? _imageFile;
  File? get imageFile => _imageFile;

  double? get selectedLat => _selectedLat;
  double? get selectedLon => _selectedLon;


  void setImageFile(File? imageFile) {
    _imageFile = imageFile;
    notifyListeners();
  }

  void setLocation(double lat, double lon) {
    _selectedLat = lat;
    _selectedLon = lon;
    notifyListeners();
  }

  void deleteLocation() {
    _selectedLat = null;
    _selectedLon = null;
    notifyListeners();
  }

}
