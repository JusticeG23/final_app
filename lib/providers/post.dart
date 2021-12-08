import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Tag { Summer, Winter, Fall, Spring }

class Post {
  // String id;
  // DateTime time;
  final String user;
  final String imageUrl;
  final String caption;
  final Tag tag;
  // int likes;
  // List<String> comments;

  Post({
    required this.user,
    required this.imageUrl,
    required this.caption,
    required this.tag,
    // required this.likes,
  });
}

class Cart with ChangeNotifier {
  // Add a Like
  // Save a post
  // Add a comment
  Map<String, Post> _items = {};

  // Map<String, Post> get items {
  //   return {..._items};
  // }

  // int get itemCount {
  //   return _items.length;
  // }

  // double get totalAmount {
  //   var total = 0.0;
  //   _items.forEach((key, cartItem) {
  //     total += cartItem.price * cartItem.quantity;
  //   });
  //   return total;
  // }

  // void addItem(
  //   String productId,
  //   double price,
  //   String title,
  // ) {
  //   if (_items.containsKey(productId)) {
  //     // change quantity...
  //     _items.update(
  //       productId,
  //       (existingCartItem) => Post(
  //         id: existingCartItem.id,
  //         title: existingCartItem.title,
  //         price: existingCartItem.price,
  //         quantity: existingCartItem.quantity + 1,
  //       ),
  //     );
  //   } else {
  //     _items.putIfAbsent(
  //       productId,
  //       () => CartItem(
  //         id: DateTime.now().toString(),
  //         title: title,
  //         price: price,
  //         quantity: 1,
  //       ),
  //     );
  //   }
  //   notifyListeners();
  // }

  // void removeItem(String productId) {
  //   _items.remove(productId);
  //   notifyListeners();
  // }

  // void removeSingleItem(String productId) {
  //   if (!_items.containsKey(productId)) {
  //     return;
  //   }
  //   if (_items[productId].quantity > 1) {
  //     _items.update(
  //         productId,
  //         (existingCartItem) => CartItem(
  //               id: existingCartItem.id,
  //               title: existingCartItem.title,
  //               price: existingCartItem.price,
  //               quantity: existingCartItem.quantity - 1,
  //             ));
  //   } else {
  //     _items.remove(productId);
  //   }
  //   notifyListeners();
  // }

  // void clear() {
  //   _items = {};
  //   notifyListeners();
  // }
}
