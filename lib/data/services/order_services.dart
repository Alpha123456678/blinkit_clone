import 'package:flutter/foundation.dart';

class OrderItem {
  final String name;
  final String image;
  final double price;
  final int quantity;

  OrderItem({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  double get total => price * quantity;
}

class Order {
  final String orderId;
  final List<OrderItem> items;
  final double totalAmount;
  final DateTime date;

  Order({
    required this.orderId,
    required this.items,
    required this.totalAmount,
    required this.date,
  });
}

class OrderService extends ChangeNotifier {
  static final OrderService instance = OrderService._internal();

  OrderService._internal();

  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  void placeOrder({
    required List<OrderItem> items,
    required double totalAmount,
  }) {
    final order = Order(
      orderId: "ORD${DateTime.now().millisecondsSinceEpoch}",
      items: List.from(items),
      totalAmount: totalAmount,
      date: DateTime.now(),
    );

    _orders.insert(0, order);

    notifyListeners();
  }
}