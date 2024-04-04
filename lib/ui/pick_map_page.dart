import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:provider/provider.dart';
import 'package:story_apps/provider/location_provider.dart';
import 'package:story_apps/widgets/placemark_widget.dart';

class PickMapPage extends StatefulWidget {
  const PickMapPage({super.key});

  @override
  State<PickMapPage> createState() => _PickMapPageState();
}

class _PickMapPageState extends State<PickMapPage> {
  final myLocation = const LatLng(-7.727224919152739, 109.00951879344684);
  late GoogleMapController mapController;
  late final Set<Marker> markers = {};
  LatLng? latLon;
  geo.Placemark? placemark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        actions: [
          Consumer<LocationProvider>(
            builder: (context, provider, state) {
              return IconButton(
                onPressed: () {
                  context.goNamed('upload');
                  provider.setLocation(placemark!.subLocality, latLon);
                },
                icon: const Icon(Icons.check),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                zoom: 18,
                target: myLocation,
              ),
              markers: markers,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              onLongPress: (LatLng latLng) => onLongPressGoogleMap(latLng),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: FloatingActionButton(
                child: const Icon(Icons.my_location),
                onPressed: () {
                  onMyLocationButtonPress();
                },
              ),
            ),
            if (placemark == null)
              const SizedBox()
            else
              Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: PlacemarkWidget(
                  placemark: placemark!,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void onMyLocationButtonPress() async {
    final Location location = Location();
    late bool enableGPS;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    enableGPS = await location.serviceEnabled();
    if (!enableGPS) {
      enableGPS = await location.requestService();
      if (!enableGPS) {
        const ScaffoldMessenger(
          child: SnackBar(
            content: Text('Gps Tidak Aktif'),
          ),
        );
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        const ScaffoldMessenger(
          child: SnackBar(
            content: Text('tidak ada permission'),
          ),
        );
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    onLongPressGoogleMap(latLng);
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
      latLon = latLng;
      markers.clear();
      markers.add(marker);
    });
  }

  void onLongPressGoogleMap(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      placemark = place;
      addMarker(latLng, street, address);
    });

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }
}
