import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Tag { Summer, Winter, Fall, Spring }

class Post {
  // String id;
  // DateTime time;
  String user;
  String imageUrl;
  String caption;
  // final Tag tag;
  // int likes;
  // List<String> comments;

  Post({
    required this.user,
    required this.imageUrl,
    required this.caption,
    // required this.tag,
    // required this.likes,
  });

  void setUser(String name) {
    this.user = name;
  }

  void setImage(String name) {
    this.user = name;
  }

  void setCap(String name) {
    this.user = name;
  }

  String getUser() {
    return user;
  }

  String getImageUrl() {
    return imageUrl;
  }

  String getCaption() {
    return caption;
  }
}

class Cart with ChangeNotifier {
  // Add a Like
  // Save a post
  // Add a comment
  Map<String, Post> _items = {};
}
