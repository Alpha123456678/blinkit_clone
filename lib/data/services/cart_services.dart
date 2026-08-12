import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  final String image;
  final double price;

  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 0,
  });

  double get totalPrice => price * quantity;
}

class CartService extends ChangeNotifier {
  static final CartService instance = CartService._internal();

  CartService._internal();

  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();

  int get totalItems {
    int total = 0;

    for (final item in _items.values) {
      total += item.quantity;
    }

    return total;
  }

  double get totalPrice {
    double total = 0;

    for (final item in _items.values) {
      total += item.totalPrice;
    }

    return total;
  }

  int getQuantity(String id) {
    return _items[id]?.quantity ?? 0;
  }

  void addItem({
    required String id,
    required String name,
    required String image,
    required double price,
  }) {
    if (_items.containsKey(id)) {
      _items[id]!.quantity++;
    } else {
      _items[id] = CartItem(
        id: id,
        name: name,
        image: image,
        price: price,
        quantity: 1,
      );
    }

    notifyListeners();
  }

  void removeItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }

    if (_items[id]!.quantity > 1) {
      _items[id]!.quantity--;
    } else {
      _items.remove(id);
    }

    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}