import 'package:flutter/foundation.dart';

class CartItem {
  final String name;
  final String image;
  final int price;
  int quantity;

  CartItem({
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 0,
  });
}

class CartService extends ChangeNotifier {
  static final CartService instance = CartService._internal();

  CartService._internal();

  final List<CartItem> _items = [
    CartItem(
      name: "Golden Glass Wooden Lid Candle (Oudh)",
      image: "image 54.png",
      price: 79,
    ),
    CartItem(
      name: "Royal Gulab Jamun By Bikano",
      image: "image 57.png",
      price: 79,
    ),
    CartItem(
      name: "Golden Glass Wooden Lid Candle (Oudh)",
      image: "image 63.png",
      price: 79,
    ),
  ];

  List<CartItem> get items => _items;

  void addItem(int index) {
    _items[index].quantity++;
    notifyListeners();
  }

  void removeItem(int index) {
    if (_items[index].quantity > 0) {
      _items[index].quantity--;
      notifyListeners();
    }
  }

  int get totalItems {
    int total = 0;

    for (final item in _items) {
      total += item.quantity;
    }

    return total;
  }

  int get totalPrice {
    int total = 0;

    for (final item in _items) {
      total += item.price * item.quantity;
    }

    return total;
  }
}