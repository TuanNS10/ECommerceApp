import 'package:ecommerce_app/models/cart_attr.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttrModel> _cartItems = {};

  Map<String, CartAttrModel> get getCartItems {
    return {..._cartItems};
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addProductToCat(
      String productId, double price, String title, String imageUrl) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (exitingCartItem) => CartAttrModel(
              id: exitingCartItem.id,
              title: exitingCartItem.title,
              quantity: exitingCartItem.quantity + 1,
              price: exitingCartItem.price,
              imageUrl: exitingCartItem.imageUrl));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartAttrModel(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price,
              imageUrl: imageUrl));
    }
    notifyListeners();
  }

  void reduceItemByOne(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (exitingCartItem) => CartAttrModel(
              id: exitingCartItem.id,
              title: exitingCartItem.title,
              quantity: exitingCartItem.quantity - 1,
              price: exitingCartItem.price,
              imageUrl: exitingCartItem.imageUrl));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
