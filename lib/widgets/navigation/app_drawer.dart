// Flutter imports
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_app/screens/device_control_webview_screen.dart';

// File imports
import 'package:final_app/screens/initialize_frames_screen.dart';
import 'package:final_app/screens/landing_screen.dart';
import 'package:final_app/screens/pictures_screen.dart';

// vanilla App drawer for navigation
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Finals used in this widget
    // final user = FirebaseAuth.instance.currentUser;
    return Container(
      width: 200,
      child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: Container(
            // decoration: BoxDecoration(
            //     border: Border.all(),
            //     borderRadius: BorderRadius.all(Radius.circular(20)),
            //     color: Colors.red),
            color: Colors.black.withOpacity(0.36),
            child: Column(
              children: <Widget>[
                // AppBar(
                //   title: Text('Navigation'),
                //   automaticallyImplyLeading: false,
                // ),
                Divider(),
                Divider(),
                Divider(),
                Divider(),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 2,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LandingScreen.routeName);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.photo,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Pictures',
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 2,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(PicturesScreen.routeName);
                  },
                ),
                // Divider(),
                // ListTile(
                //   leading: Icon(Icons.settings),
                //   title: Text('Initialize Frames'),
                //   onTap: () {
                //     Navigator.of(context)
                //         .pushReplacementNamed(InitializeFramesScreen.routeName);
                //   },
                // ),
                // Divider(),
                // ListTile(
                //   leading: Icon(Icons.bug_report),
                //   title: Text('Device Control (Dev Mode)'),
                //   onTap: () {
                //     Navigator.of(context)
                //         .pushReplacementNamed(DeviceControlWebviewScreen.routeName);
                //   },
                // ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 2,
                  ),
                  onTap: () {
                    while (Navigator.of(context).canPop())
                      Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed("/");
                    // FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          )),
    );
  }
}
