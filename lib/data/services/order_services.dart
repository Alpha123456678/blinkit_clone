import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "image": image,
      "price": price,
      "quantity": quantity,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      name: map["name"] ?? "",
      image: map["image"] ?? "",
      price: (map["price"] ?? 0).toDouble(),
      quantity: map["quantity"] ?? 0,
    );
  }
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

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  Future<void> placeOrder({
    required List<OrderItem> items,
    required double totalAmount,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User is not logged in");
    }

    final orderId =
        "ORD${DateTime.now().millisecondsSinceEpoch}";

    final orderData = {
      "orderId": orderId,
      "totalAmount": totalAmount,
      "date": FieldValue.serverTimestamp(),
      "items": items.map((item) => item.toMap()).toList(),
    };

    await _firestore
        .collection("users")
        .doc(user.uid)
        .collection("orders")
        .doc(orderId)
        .set(orderData);

    final order = Order(
      orderId: orderId,
      items: List.from(items),
      totalAmount: totalAmount,
      date: DateTime.now(),
    );

    _orders.insert(0, order);

    notifyListeners();
  }

  Future<void> loadOrders() async {
    final user = _auth.currentUser;

    if (user == null) {
      return;
    }

    final snapshot = await _firestore
        .collection("users")
        .doc(user.uid)
        .collection("orders")
        .orderBy("date", descending: true)
        .get();

    _orders.clear();

    for (final doc in snapshot.docs) {
      final data = doc.data();

      final List<dynamic> itemData =
          data["items"] ?? [];

      final items = itemData
          .map(
            (item) => OrderItem.fromMap(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();

      final timestamp = data["date"] as Timestamp?;

      _orders.add(
        Order(
          orderId: data["orderId"] ?? doc.id,
          items: items,
          totalAmount:
              (data["totalAmount"] ?? 0).toDouble(),
          date: timestamp?.toDate() ?? DateTime.now(),
        ),
      );
    }

    notifyListeners();
  }

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}