// NOTE Will need to authenticate on FRAMES using HTTP requests so will likely
// need to pass username/password to FRAMES
// https://firebase.google.com/docs/reference/rest/auth#section-verify-custom-token

// Dart imports
import 'dart:convert';

// Flutter imports
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../constants/pictureList.dart';

// File Imports
import '../widgets/navigation/app_drawer.dart';

class PicturesScreen extends StatefulWidget {
  // Route name declaration
  static const routeName = '/pictures';

  @override
  _PicturesScreenState createState() => _PicturesScreenState();
}

class _PicturesScreenState extends State<PicturesScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pictures'),
      ),
      drawer: AppDrawer(),
      body: GridView.count(
        crossAxisCount: 4,
        children: picturesList
            .map(
              (word) => Container(
                child: Image.network(
                  word,
                  height: 60.0,
                  fit: BoxFit.cover,
                ),
              ),
            )
            .toList(),
        // <Widget>[
        //   Container(
        //     child: Image.network(
        //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
        //       height: 60.0,
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   Container(
        //     child: Text('long information text'),
        //   ),
        // ],
      ),
    );
  }
}
