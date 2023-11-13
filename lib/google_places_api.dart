import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_map_api/keys/apikey.dart';
import 'package:uuid/uuid.dart';

import 'package:http/http.dart' as http;

class GooglePlaceApi extends StatefulWidget {
  const GooglePlaceApi({super.key});

  @override
  State<GooglePlaceApi> createState() => _GooglePlaceApiState();
}

class _GooglePlaceApiState extends State<GooglePlaceApi> {
  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '1234';
  List<dynamic> _placeslist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = ApiKey;
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print('data');
    print(data);
    if (response.statusCode == 200) {
      setState(() {
        _placeslist = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auto Complete Places"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Search places with name'),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _placeslist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    List<Location> locations = await locationFromAddress(
                        _placeslist[index]['description']);
                    print(locations.last.latitude);
                    print(locations.last.longitude);
                  },
                  title: Text(_placeslist[index]['description']),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
