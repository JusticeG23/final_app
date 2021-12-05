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
      // backgroundColor: Theme.of(context).backgroundColor,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Pictures'),
      ),
      drawer: AppDrawer(),
      body: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
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
      ),
    );
  }
}
