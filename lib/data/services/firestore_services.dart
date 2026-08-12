import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all products
  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() {
    return _firestore.collection('products').snapshots();
  }

  // Add a product
  Future<void> addProduct({
    required String name,
    required String image,
    required String category,
    required double price,
  }) async {
    await _firestore.collection('products').add({
      'name': name,
      'image': image,
      'category': category,
      'price': price,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Get products by category
  Stream<QuerySnapshot<Map<String, dynamic>>> getProductsByCategory(
    String category,
  ) {
    return _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .snapshots();
  }
}