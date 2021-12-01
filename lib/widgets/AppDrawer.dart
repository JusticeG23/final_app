import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/setting_screen.dart';

class AppDrawer extends StatelessWidget {
  Widget buildListTile(IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Menu',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(Icons.save, () {}),
          buildListTile(Icons.person, () {
            Navigator.of(context)
                .pushReplacementNamed(EditProfileScreen.routeName);
          }),
          buildListTile(Icons.mail, () {
            Navigator.of(context).pushReplacementNamed(ChatScreen.routeName);
          }),
          buildListTile(Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(SettingScreen.routeName);
          }),
        ],
      ),
    );
  }
}
