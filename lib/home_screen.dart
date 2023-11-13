import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _mapcontroller =
      Completer(); //when camera is moving the controller ,locatet the changes observed and save in it.

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.450872845415056, 77.58422999183854),
    zoom: 14.4746,
  );

  List<Marker> _marker = [];

  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(28.450872845415056, 77.58422999183854),
      infoWindow: InfoWindow(
        title: 'My Current location',
      ),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(28.450778535734774, 77.58066800770574),
      infoWindow: InfoWindow(
        title: 'My Current location',
      ),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(28.449108869435396, 77.57991701326283),
      infoWindow: InfoWindow(
        title: 'My Current location',
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition:
              _kGooglePlex, //inital position of the google map location.
          markers: Set<Marker>.of(_marker),
          // mapType: MapType.hybrid,
          onMapCreated: (GoogleMapController controller) {
            _mapcontroller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_disabled_outlined),
        onPressed: () async {
          GoogleMapController controller = await _mapcontroller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(28.62453922757371, 77.03686460108555),
                zoom: 14.4746,
              ),
            ),
          );
        },
      ),
    );
  }
}
