import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geo;

class MapPage extends StatefulWidget {
  final String id;
  final String lat;
  final String lon;

  const MapPage({
    super.key,
    required this.id,
    required this.lat,
    required this.lon,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    final latLng = LatLng(
      double.parse(widget.lat),
      double.parse(widget.lon),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: latLng,
                zoom: 18,
              ),
              onMapCreated: (_) {
                onLongPressGoogleMap(latLng);
              },
              markers: markers,
            ),
          ],
        ),
      ),
    );
  }

  void addMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId('source'),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );

    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }

  void onLongPressGoogleMap(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    final street = place.street ?? '';
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    addMarker(latLng, street, address);
  }
}
