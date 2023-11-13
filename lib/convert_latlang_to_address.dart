import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';

class Convert_Latlang_to_address extends StatefulWidget {
  const Convert_Latlang_to_address({super.key});

  @override
  State<Convert_Latlang_to_address> createState() =>
      _Convert_Latlang_to_addressState();
}

class _Convert_Latlang_to_addressState
    extends State<Convert_Latlang_to_address> {
  String stAdrress = "";
  String stAdd = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(stAdd),
            Text(stAdrress),
            InkWell(
              onTap: () async {
                //from address
                const query = "1600 Amphiteatre Parkway, Mountain View";
                List<Location> locations = await locationFromAddress(query);

                //from coordinates
                List<Placemark> placemarks = await placemarkFromCoordinates(
                    28.450872845415056, 77.58422999183854);
                setState(() {
                  stAdd = locations.last.longitude.toString() +
                      "," +
                      locations.last.latitude.toString();
                  stAdrress = placemarks.reversed.last.name.toString();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(color: Colors.green),
                  child: Center(child: Text("Convert")),
                ),
              ),
            ),
          ]),
    );
  }
}
