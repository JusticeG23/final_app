// NOTE Will need to authenticate on FRAMES using HTTP requests so will likely
// need to pass username/password to FRAMES
// https://firebase.google.com/docs/reference/rest/auth#section-verify-custom-token

// Dart imports
import 'dart:convert';
// import 'package:basic_image_gallery/image_gallery.dart';

// Flutter imports
import 'package:final_app/providers/post.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../constants/pictureList.dart';

// File Imports
import '../widgets/navigation/app_drawer.dart';

// Gloabal Constant
Post localPost = Post(
  user: '',
  imageUrl: '',
  caption: '',
);
String tempString = '';

class PicturesScreen extends StatefulWidget {
  // Route name declaration
  static const routeName = '/pictures';

  @override
  _PicturesScreenState createState() => _PicturesScreenState();
}

List<String> getUrls(localList) {
  List<String> returnList = [];
  for (var i = 0; i < localList.length; i++) {
    returnList.add(localList[i].imageUrl);
  }
  return returnList;
}

void printList(picturesList) {
  // print("printing list:");
  for (var i = 0; i < picturesList.length; i++) {
    print(picturesList[i].user);
    print(picturesList[i].imageUrl);
    print(picturesList[i].caption);
  }
}

void makePost(context) {
  // if (localPost.user != '' &&
  //     !localPost.user.isEmpty &&
  //     localPost.imageUrl != '' &&
  //     !localPost.imageUrl.isEmpty &&
  //     localPost.caption != '' &&
  //     !localPost.caption.isEmpty) {
  // print("the list before:-----------------------------------");
  // printList(picturesList);
  picturesList.add(
    Post(
        user: 'test',
        imageUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.RcMo9n0zY5wL7ULr5smhMwHaEK%26pid%3DApi&f=1',
        caption: 'test'),
  );
  // }
  Navigator.pop(context, 'OK');
  // print("the list after:-----------------------------------");
  // printList(picturesList);
}

// Creates a screen for viewing pictures as grid with default layout
class _PicturesScreenState extends State<PicturesScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      // backgroundColor: Colors.grey,
      appBar: AppBar(title: Text('Pictures'), actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              // title: const Text('Would you like to make a post?'),
              content:
                  // ImageGallery(
                  //     initialPage: 1, files: [], networkUrl: getUrls(picturesList)),
                  Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'What\'s Your username?',
                      labelText: 'Name',
                    ),
                    onSaved: (String? value) {
                      localPost.setUser(value.toString());
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.photo),
                      hintText: 'Image URL',
                      labelText: 'URL',
                    ),
                    onSaved: (String? value) {
                      tempString = 'some stupid stupid property idk';
                      // localPost.setImage(value.toString());
                      print(tempString);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.comment),
                      hintText: 'Here you can Caption your photo',
                      labelText: 'caption',
                    ),
                    onSaved: (String? value) {
                      localPost.setCap(value.toString());
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => setState(() {
                    makePost(context);
                  }),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        )
      ]),
      drawer: AppDrawer(),
      // Create the Gridview.count for minimal dependencies
      body: Container(
        decoration: BoxDecoration(
            // border: Border.all(),
            color: Colors.black),
        child: GridView.count(
          // Defined layout values
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          // Contructs containers from element from list picturesList
          children: (picturesList.reversed.toList() as List<Post>)
              .map(
                (post) => Container(
                  decoration: BoxDecoration(
                      // border: Border.all(),
                      // borderRadius: BorderRadius.all(
                      //   Radius.circular(25),
                      // ),
                      ),
                  child: Image.network(
                    post.imageUrl,
                    height: 60.0,
                    fit: BoxFit.cover,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
