# google_map_api

1. create project in google map console and  enable api (map for android and map for ios in google cloud console)
2. Setting up the project with google map api console.
  - add dependencies https://pub.dev/packages/google_maps_flutter
  - Set the minSdkVersion in android/app/build.gradle:
  - Specify your API key in the application manifest android/app/src/main/AndroidManifest.xml:
        `<manifest ...
          <application ...
            <meta-data android:name="com.google.android.geo.API_KEY"
                 android:value="YOUR KEY HERE"/>
    
4. 
