//https://youtu.be/5RxYuukAjgg?si=pB7MkiOvjym572sO

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class User_current_location extends StatefulWidget {
  const User_current_location({super.key});

  @override
  State<User_current_location> createState() => _User_current_locationState();
}

class _User_current_locationState extends State<User_current_location> {
  final Completer<GoogleMapController> _mapcontroller =
      Completer(); //when camera is moving the controller ,locatet the changes observed and save in it.

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.450872845415056, 77.58422999183854),
    zoom: 14.4746,
  );

  final List<Marker> _marker = [];

  final List<Marker> _list = [
    const Marker(
      markerId: MarkerId('2'),
      position: LatLng(28.450778535734774, 77.58066800770574),
      infoWindow: InfoWindow(
        title: 'My Current location',
      ),
    ),
    const Marker(
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
    loadLocation();
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
        onPressed: () {
          getUserCurrentLocation().then((value) async {
            print("my current location");
            print(value.latitude.toString() + " " + value.longitude.toString());

            _marker.add(
              Marker(
                markerId: MarkerId('4'),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: InfoWindow(
                  title: 'My Current location',
                ),
              ),
            );

            CameraPosition cameraPosition = CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 14.467,
            );

            final GoogleMapController controller = await _mapcontroller.future;

            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

            setState(() {});
          });
        },
      ),
    );
  }

  loadLocation() {
    getUserCurrentLocation().then((value) async {
      print("my current location");
      print(value.latitude.toString() + " " + value.longitude.toString());

      _marker.add(
        Marker(
          markerId: MarkerId('4'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(
            title: 'My Current location',
          ),
        ),
      );

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14.467,
      );

      final GoogleMapController controller = await _mapcontroller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {});
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
}
