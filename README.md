# google_map_api

1. create project in google map console and  enable api (map for android and map for ios in google cloud console)
2. Setting up the project with google map api console.
  - add dependencies https://pub.dev/packages/google_maps_flutter
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




