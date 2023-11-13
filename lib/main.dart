import 'package:flutter/material.dart';
import 'package:google_map_api/convert_latlang_to_address.dart';
import 'package:google_map_api/google_places_api.dart';
import 'package:google_map_api/home_screen.dart';
import 'package:google_map_api/user_current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GooglePlaceApi(),
    );
  }
}
