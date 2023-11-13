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

- take user permissions. to enable location
  ```
  <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
  <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
  ```


