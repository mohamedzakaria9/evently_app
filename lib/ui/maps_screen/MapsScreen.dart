import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});
  static int markerId = 1;

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final Set<Marker> markers = {
    Marker(
      markerId: MarkerId("${MapsScreen.markerId}"),
      position: LatLng(30.0444, 31.2357),
    ),
    Marker(
      markerId: MarkerId("${++MapsScreen.markerId}"),
      position: LatLng(30.1444, 31.2340),
    ),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(30.0444, 31.2357),
          zoom: 5,
        ),
        myLocationButtonEnabled: true,
        markers: markers,
        onTap: (argument) {
          markers.add(
            Marker(
              markerId: MarkerId("${++MapsScreen.markerId}"),
              position: LatLng(argument.latitude, argument.longitude)
            )
          );
          setState(() {
            print(markers.length);
            print(argument.latitude);
            print(argument.longitude);
          });
        },
      ),
    );
  }
}
