import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  final double lat;
  final double lon;

  const MapPage({Key? key, required this.lat, required this.lon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Lokasi'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, lon),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('StoryLocation'),
            position: LatLng(lat, lon),
          ),
        },
      ),
    );
  }
}
