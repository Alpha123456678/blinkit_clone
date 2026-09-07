import 'package:blinkit_app/data/services/cart_services.dart';
import 'package:blinkit_app/data/services/product_service.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController =
      TextEditingController();

  final ProductService productService = ProductService();

  String searchQuery = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // =========================================================
  // SEARCH
  // =========================================================

  void searchProducts(String value) {
    setState(() {
      searchQuery = value.trim().toLowerCase();
    });
  }

  // =========================================================
  // PRODUCT BUTTON
  // =========================================================

  Widget productButton(Map<String, dynamic> product) {
    final String id = product["id"].toString();

    final String name = product["name"]?.toString() ?? "";

    final String image = product["image"]?.toString() ?? "";

    final double price =
        (product["price"] as num?)?.toDouble() ?? 0;

    return AnimatedBuilder(
      animation: CartService.instance,
      builder: (context, child) {
        final quantity =
            CartService.instance.getQuantity(id);

        // =====================================================
        // ADD BUTTON
        // =====================================================

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
                    content: Text("Product added to cart"),
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

        // =====================================================
        // QUANTITY BUTTON
        // =====================================================

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
  // PRODUCT IMAGE
  // =========================================================

  Widget productImage(String image) {
    // If Firestore contains a network URL
    if (image.startsWith("http://") ||
        image.startsWith("https://")) {
      return Image.network(
        image,
        fit: BoxFit.contain,
        errorBuilder:
            (context, error, stackTrace) {
          return const Icon(
            Icons.image_not_supported,
            color: Colors.grey,
            size: 35,
          );
        },
      );
    }

    // If Firestore contains an asset filename
    return Image.asset(
      "assets/images/$image",
      fit: BoxFit.contain,
      errorBuilder:
          (context, error, stackTrace) {
        return const Icon(
          Icons.image_not_supported,
          color: Colors.grey,
          size: 35,
        );
      },
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFF7CB45),
        foregroundColor: Colors.black,
        title: const Text(
          "Search",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          // ===================================================
          // SEARCH FIELD
          // ===================================================

          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: searchController,
              autofocus: true,
              onChanged: searchProducts,
              decoration: InputDecoration(
                hintText: "Search for products",
                prefixIcon: const Icon(
                  Icons.search,
                ),

                suffixIcon:
                    searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              searchController.clear();

                              setState(() {
                                searchQuery = "";
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                            ),
                          )
                        : null,

                filled: true,
                fillColor: Colors.grey.shade100,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // ===================================================
          // FIRESTORE PRODUCTS
          // ===================================================

          Expanded(
            child: StreamBuilder(
              stream: productService.getProducts(),

              builder: (context, snapshot) {
                // =================================================
                // LOADING
                // =================================================

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                // =================================================
                // ERROR
                // =================================================

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 60,
                            color: Colors.red,
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            "Something went wrong",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            snapshot.error.toString(),
                            textAlign:
                                TextAlign.center,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // =================================================
                // NO DATA
                // =================================================

                if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 70,
                          color: Colors.grey,
                        ),

                        SizedBox(height: 10),

                        Text(
                          "No products available",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // =================================================
                // GET PRODUCTS
                // =================================================

                final products =
                    snapshot.data!.docs
                        .map((doc) {
                  final data = doc.data();

                  return {
                    "id": doc.id,
                    ...data,
                  };
                }).where((product) {

                  // Empty search
                  if (searchQuery.isEmpty) {
                    return true;
                  }

                  final name =
                      product["name"]
                              ?.toString()
                              .toLowerCase() ??
                          "";

                  final category =
                      product["category"]
                              ?.toString()
                              .toLowerCase() ??
                          "";

                  // Search by name OR category
                  return name.contains(searchQuery) ||
                      category.contains(searchQuery);
                }).toList();

                // =================================================
                // NO SEARCH RESULTS
                // =================================================

                if (products.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 70,
                          color: Colors.grey,
                        ),

                        SizedBox(height: 10),

                        Text(
                          "No products found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          "Try searching for another product",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // =================================================
                // PRODUCT LIST
                // =================================================

                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  itemCount: products.length,

                  itemBuilder:
                      (context, index) {
                    final product =
                        products[index];

                    final String name =
                        product["name"]
                                ?.toString() ??
                            "";

                    final String category =
                        product["category"]
                                ?.toString() ??
                            "";

                    final String image =
                        product["image"]
                                ?.toString() ??
                            "";

                    final double price =
                        (product["price"]
                                    as num?)
                                ?.toDouble() ??
                            0;

                    return Container(
                      margin:
                          const EdgeInsets.only(
                        bottom: 12,
                      ),

                      padding:
                          const EdgeInsets.all(
                        10,
                      ),

                      decoration:
                          BoxDecoration(
                        border: Border.all(
                          color:
                              Colors.grey.shade300,
                        ),
                        borderRadius:
                            BorderRadius.circular(
                          10,
                        ),
                      ),

                      child: Row(
                        children: [
                          // ======================================
                          // IMAGE
                          // ======================================

                          Container(
                            height: 80,
                            width: 80,
                            decoration:
                                BoxDecoration(
                              color: const Color(
                                0XFFF5F5F5,
                              ),
                              borderRadius:
                                  BorderRadius.circular(
                                8,
                              ),
                            ),

                            child:
                                productImage(image),
                          ),

                          const SizedBox(
                            width: 12,
                          ),

                          // ======================================
                          // PRODUCT INFORMATION
                          // ======================================

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [
                                Text(
                                  name,
                                  maxLines: 2,
                                  overflow:
                                      TextOverflow
                                          .ellipsis,
                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),

                                const SizedBox(
                                  height: 5,
                                ),

                                if (category
                                    .isNotEmpty)
                                  Text(
                                    category,
                                    style:
                                        const TextStyle(
                                      color:
                                          Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),

                                const SizedBox(
                                  height: 7,
                                ),

                                Text(
                                  "₹${price.toStringAsFixed(0)}",
                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            width: 5,
                          ),

                          // ======================================
                          // ADD / QUANTITY
                          // ======================================

                          productButton(product),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}