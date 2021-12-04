// Flutter imports
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// File imports
import './auth_screen.dart';
import './landing_screen.dart';

//////////////////////////////////////////////////////////////////
// StateLESS widget which only has data that is initialized when
// widget is created (cannot update except when re-created).
//////////////////////////////////////////////////////////////////
class SplashScreen extends StatelessWidget {
  // Route name declaration
  static const routeName = '/splash';

  ////////////////////////////////////////////////////////////////
  // Primary Flutter method overriden which describes the layout
  // and bindings for this widget.
  ////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    // Upon starting the app, initialize the Firebase package
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
        future: _initialization,
        builder: (context, appSnapshot) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting)
                return Text('Authenticating user...');
              else if (!userSnapshot.hasData)
                return AuthScreen();
              else
                return LandingScreen();
            },
          );
        },
      ),
    );
  }
}
