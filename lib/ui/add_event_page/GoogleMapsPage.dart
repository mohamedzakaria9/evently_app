import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class GoogleMapsPage extends StatefulWidget {

  GoogleMapsPage({super.key});

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  LatLng? selectedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context,selectedPosition);
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(30.0444, 31.2357), // Cairo example
          zoom: 12,
        ),
        onTap: (argument) {
          selectedPosition = argument;
          setState(() {

          });
        },
        markers: selectedPosition != null ?{
          Marker(
            markerId: MarkerId("1"),
            position: LatLng(selectedPosition!.latitude, selectedPosition!.longitude),
          ),
        }:{}
      ),
    );
  }
}
