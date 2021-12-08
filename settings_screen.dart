import 'package:flutter/material.dart';
import 'package:globe_frames_eu_app/constants/config.dart';
//import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:globe_frames_eu_app/widgets/navigation/app_drawer.dart';

class SettingScreen extends StatefulWidget {
  static final routeName = '/settings';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var _icon = Icons.wb_incandescent;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text('Dark/Light mode'),
                leading: Icon(Icons.dark_mode),
                trailing: RaisedButton(
                  child: Text('Theme mode'),
                  onPressed: () => currentTheme.switchTheme(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
