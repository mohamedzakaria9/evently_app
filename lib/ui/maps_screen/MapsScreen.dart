import 'package:evently_app/models/LocalUser.dart';
import 'package:evently_app/providers/EventsProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    var eventsLocationProvider = Provider.of<EventsProvider>(context);
    eventsLocationProvider.getLocations(uId: LocalUser.uId!);
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(30.0444, 31.2357),
          zoom: 5,
        ),
        myLocationButtonEnabled: true,
        markers: eventsLocationProvider.eventsLocations,
      ),
    );
  }
}
