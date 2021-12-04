// Flutter imports
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_app/screens/device_control_webview_screen.dart';

// File imports
import 'package:final_app/screens/initialize_frames_screen.dart';
import 'package:final_app/screens/landing_screen.dart';
import 'package:final_app/screens/pictures_screen.dart';

//////////////////////////////////////////////////////////////////
// StateLESS widget which only has data that is initialized when
// widget is created (cannot update except when re-created).
//////////////////////////////////////////////////////////////////
class AppDrawer extends StatelessWidget {
  ////////////////////////////////////////////////////////////////
  // Primary Flutter method overriden which describes the layout
  // and bindings for this widget.
  ////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    // Finals used in this widget
    // final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Navigation'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(LandingScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Pictures'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(PicturesScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Initialize Frames'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(InitializeFramesScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: Text('Device Control (Dev Mode)'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(DeviceControlWebviewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              while (Navigator.of(context).canPop())
                Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed("/");
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
