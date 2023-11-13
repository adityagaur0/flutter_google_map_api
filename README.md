# google_map_api

1. create project in google map console and  enable api (map for android and map for ios in google cloud console)
2. Setting up the project with google map api console.
  - add dependencies [https://pub.dev/packages/google_maps_flutter]
  - Set the minSdkVersion in android/app/build.gradle:
  - Specify your API key in the application manifest android/app/src/main/AndroidManifest.xml:
```
<manifest ...
  <application ...
    <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="YOUR KEY HERE"/>
```
2
    - for ios,in your swift code, specify your API key in the application delegate ios/Runner/AppDelegate.swift:
    
```
import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("YOUR KEY HERE")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```
  - update the dependencies for ios tooo.
    go to terminal-> cd ios -> pod update (after install get out of the folder) -> cd ..
    
3. Flutter Integrating Google Map with null safety(make sure ur emulator is connected to internet).
   - To get the inital position of the camera

     <img width="914" alt="Screenshot 2023-11-13 at 5 03 37 PM" src="https://github.com/adityagaur0/google_map_api/assets/112656570/ee4f8c01-2b2b-445d-8cf9-68dc9904a868">

4. Add multiple marker on google map
   
   <img width="461" alt="Screenshot 2023-11-13 at 5 16 05 PM" src="https://github.com/adityagaur0/google_map_api/assets/112656570/ae27c3a4-e462-41c3-b76b-7869529f5a9b">
   
   <img width="272" alt="Screenshot 2023-11-13 at 5 16 30 PM" src="https://github.com/adityagaur0/google_map_api/assets/112656570/6c6a1469-3516-4395-9554-4a59d1a49349">


5. Animate camera to move at any position in the map
   
  <img width="632" alt="Screenshot 2023-11-13 at 5 29 37 PM" src="https://github.com/adityagaur0/google_map_api/assets/112656570/f746e9e3-0128-4bb5-aee7-183a88d6d170">

6. convert coordinates(Lat/Long) to address in Flutter
  - add dependencies [geocoding: ^2.1.1](https://pub.dev/packages/geocoding) convert latitude and longitude to address and vice versa.\
    
   <img width="694" alt="Screenshot 2023-11-13 at 6 12 17 PM" src="https://github.com/adityagaur0/google_map_api/assets/112656570/2398b30e-b621-4281-878c-9837dfda6b53">

<img width="332" alt="Screenshot 2023-11-13 at 5 59 26 PM" src="https://github.com/adityagaur0/google_map_api/assets/112656570/490127fd-58eb-447c-a768-e0cc2305db14">

7. Flutter Get user current location and show on marker with address

- take user permissions. to enable location android.
  ```
  <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
  <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
  ```

ios Permissions
```
<key>NSLocationAlwaysAndWhenInUsageDescription</key>
	<string>App app want's to access your location to get address</string>
	<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
	<string>App app want's to access your location to get address.</string>
	<key>NSLocationAlwaysUsageDescription</key>
	<string>App app want's to access your location to get address.</string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string> App want's to access your location to get address.</string>
```

- add dependencies [geolocator: ^10.1.0](https://pub.dev/packages/geocoding)

  
  
<img width="741" alt="Screenshot 2023-11-13 at 7 06 23 PM" src="https://github.com/adityagaur0/google_map_api/assets/112656570/a4345183-1d21-4d2b-952b-82b4173454d0">
<img width="330" alt="Screenshot 2023-11-13 at 7 06 46 PM" src="https://github.com/adityagaur0/google_map_api/assets/112656570/8486b8f0-0077-4933-8ada-daf7f002389c">


8. Flutter Google Map Auto Complete Places API ***IMPPPPPPP
   - add dependencies  [UUID](https://pub.dev/packages/uuid) and [HTTP](https://pub.dev/packages/http)
   - uuid get Device unique id.
```
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
    String kPLACES_API_KEY = "AIzaSyCggsWkY_vdHiz-2i39U5mPPPseK73FP7c";
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

```


##9. Flutter Add Multiple Custom Marker On Google Map Like Snapchap
