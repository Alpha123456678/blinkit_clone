import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() {
    return _firestore.collection('products').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProductsByCategory(
    String category,
  ) {
    return _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .snapshots();
  }

  Future<void> addProduct({
    required String name,
    required String category,
    required String image,
    required double price,
    String description = '',
  }) async {
    await _firestore.collection('products').add({
      'name': name,
      'category': category,
      'image': image,
      'price': price,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}