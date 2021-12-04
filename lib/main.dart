// Flutter imports
import 'package:final_app/screens/pictures_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:final_app/screens/device_control_webview_screen.dart';

// File imports
import './screens/device_control_webview_screen.dart';
import './screens/initialize_frames_screen.dart';
import './screens/landing_screen.dart';
import './screens/splash_screen.dart';
import './screens/auth_screen.dart';

//////////////////////////////////////////////////////////////////
// MAIN entry point to start app.
//////////////////////////////////////////////////////////////////
void main() => runApp(MyApp());

//////////////////////////////////////////////////////////////////
// StateLESS widget which only has data that is initialized when
// widget is created (cannot update except when re-created).
//
// This app does NOT implement state management because it uses
// Firebase's Cloud Firestore database to sync data across multiple
// pages instead.
//////////////////////////////////////////////////////////////////
class MyApp extends StatelessWidget {
  ////////////////////////////////////////////////////////////////
  // Primary Flutter method overriden which describes the layout
  // and bindings for this widget.
  ////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    // Upon starting the app, initialize the Firebase package
    // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    // The primary widget to build and return once Firebase has been initialized
    return FutureBuilder(
      // future: _initialization,
      builder: (context, appSnapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Instafam',
          theme: ThemeData(
            primarySwatch: Colors.pink,
            backgroundColor: Colors.yellow.shade700,
            accentColor: Colors.black,
            splashColor: Colors.indigo,
            accentColorBrightness: Brightness.dark,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                onPrimary: Colors.white,
                //minimumSize: Size(200, 50),
                // textStyle: TextStyle(
                //   fontSize: 16,
                //   fontWeight: FontWeight.bold,
                // ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          home: LandingScreen(),
          routes: {
            PicturesScreen.routeName: (ctx) => PicturesScreen(),
            // AuthScreen.routeName: (ctx) => AuthScreen(),
            // LandingScreen.routeName: (ctx) => LandingScreen(),
            // InitializeFramesScreen.routeName: (ctx) => InitializeFramesScreen(),
            // DeviceControlWebviewScreen.routeName: (ctx) =>
            //     DeviceControlWebviewScreen(),
          },
        );
      },
    );
  }
}
