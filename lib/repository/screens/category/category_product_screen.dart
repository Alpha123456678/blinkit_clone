import 'package:blinkit_app/data/services/cart_services.dart';
import 'package:blinkit_app/data/services/product_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;

  const CategoryProductsScreen({
    super.key,
    required this.category,
  });

  // =========================================================
  // LOCAL BESTSELLER PRODUCTS
  // =========================================================

  final List<Map<String, dynamic>> bestsellerProducts = const [
    {
      "id": "candle_01",
      "name": "Golden Glass Wooden Lid Candle (Oudh)",
      "image": "image 54.png",
      "price": 79.0,
      "category": "Bestsellers",
    },
    {
      "id": "gulab_jamun_01",
      "name": "Royal Gulab Jamun By Bikano",
      "image": "image 57.png",
      "price": 79.0,
      "category": "Bestsellers",
    },
    {
      "id": "candle_02",
      "name": "Golden Glass Wooden Lid Candle (Oudh)",
      "image": "image 63.png",
      "price": 79.0,
      "category": "Bestsellers",
    },
  ];

  // =========================================================
  // PRODUCT IMAGE
  // =========================================================

  Widget productImage(String image) {
    if (image.startsWith("http://") ||
        image.startsWith("https://")) {
      return Image.network(
        image,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.image_not_supported,
            color: Colors.grey,
            size: 40,
          );
        },
      );
    }

    return Image.asset(
      "assets/images/$image",
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.image_not_supported,
          color: Colors.grey,
          size: 40,
        );
      },
    );
  }

  // =========================================================
  // PRODUCT BUTTON
  // =========================================================

  Widget productButton({
    required String id,
    required String name,
    required String image,
    required double price,
  }) {
    return AnimatedBuilder(
      animation: CartService.instance,
      builder: (context, child) {
        final quantity =
            CartService.instance.getQuantity(id);

        if (quantity == 0) {
          return SizedBox(
            height: 35,
            child: ElevatedButton(
              onPressed: () {
                CartService.instance.addItem(
                  id: id,
                  name: name,
                  image: image,
                  price: price,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Product added to cart",
                    ),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                "ADD",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }

        return Container(
          height: 35,
          width: 85,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  CartService.instance.removeItem(id);
                },
                child: const Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 18,
                ),
              ),

              Text(
                quantity.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              InkWell(
                onTap: () {
                  CartService.instance.addItem(
                    id: id,
                    name: name,
                    image: image,
                    price: price,
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // =========================================================
  // FIRESTORE CATEGORY SCREEN
  // =========================================================

  Widget firestoreProducts(BuildContext context) {
    final productService = ProductService();

    return StreamBuilder<
        QuerySnapshot<Map<String, dynamic>>>(
      stream:
          productService.getProductsByCategory(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Error: ${snapshot.error}",
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (!snapshot.hasData ||
            snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_bag_outlined,
                  size: 70,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                Text(
                  "No products in $category",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }

        final products = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final doc = products[index];
            final data = doc.data();

            final String id = doc.id;

            final String name =
                data["name"]?.toString() ?? "";

            final String image =
                data["image"]?.toString() ?? "";

            final double price =
                (data["price"] as num?)?.toDouble() ?? 0;

            return productCard(
              context: context,
              id: id,
              name: name,
              image: image,
              price: price,
            );
          },
        );
      },
    );
  }

  // =========================================================
  // PRODUCT CARD
  // =========================================================

  Widget productCard({
    required BuildContext context,
    required String id,
    required String name,
    required String image,
    required double price,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: const Color(0XFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: productImage(image),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  category,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "₹${price.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 8),

                productButton(
                  id: id,
                  name: name,
                  image: image,
                  price: price,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final bool isBestseller =
        category.toLowerCase() == "bestsellers";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFF7CB45),
        foregroundColor: Colors.black,
        title: Text(
          category,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: isBestseller
          ? ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: bestsellerProducts.length,
              itemBuilder: (context, index) {
                final product =
                    bestsellerProducts[index];

                return productCard(
                  context: context,
                  id: product["id"],
                  name: product["name"],
                  image: product["image"],
                  price: product["price"],
                );
              },
            )
          : firestoreProducts(context),
    );
  }
}