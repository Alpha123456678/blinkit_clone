import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<String> products = [
    "Milk",
    "Potato",
    "Tomato",
    "Rice",
    "Atta",
    "Cooking Oil",
    "Biscuits",
    "Bread",
    "Fruits",
    "Vegetables",
    "Diwali Gifts",
    "Candles",
  ];

  List<String> results = [];

  @override
  void initState() {
    super.initState();
    results = products;
  }

  void searchProducts(String value) {
    setState(() {
      results = products
          .where(
            (product) =>
                product.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: searchController,
              autofocus: true,
              onChanged: searchProducts,
              decoration: InputDecoration(
                hintText: "Search for products",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();
                          searchProducts("");
                        },
                        icon: const Icon(Icons.close),
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: results.isEmpty
                ? const Center(
                    child: Text(
                      "No products found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0XFFF7CB45),
                          child: Icon(
                            Icons.shopping_bag,
                            color: Colors.black,
                          ),
                        ),
                        title: Text(
                          results[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}