import 'package:blinkit_app/data/services/cart_services.dart';
import 'package:blinkit_app/repository/screens/cart/cartscreen.dart';
import 'package:blinkit_app/repository/screens/profile/profilescreen.dart';
import 'package:blinkit_app/repository/screens/search/searchscreen.dart';
import 'package:blinkit_app/repository/widgets/uihelper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> data = [
    {
      "img": "image 50.png",
      "text": "Lights, Diyas\n& Candles",
    },
    {
      "img": "image 51.png",
      "text": "Diwali\nGifts",
    },
    {
      "img": "image 52.png",
      "text": "Appliances\n& Gadgets",
    },
    {
      "img": "image 53.png",
      "text": "Home\n& Living",
    },
  ];

  // ================= PRODUCTS =================

  final List<Map<String, String>> category = [
    {
      "id": "candle_01",
      "img": "image 54.png",
      "text": "Golden Glass\nWooden Lid Candle (Oudh)",
      "price": "79",
    },
    {
      "id": "gulab_jamun_01",
      "img": "image 57.png",
      "text": "Royal Gulab Jamun\nBy Bikano",
      "price": "79",
    },
    {
      "id": "candle_02",
      "img": "image 63.png",
      "text": "Golden Glass\nWooden Lid Candle (Oudh)",
      "price": "79",
    },
  ];

  final List<Map<String, String>> groceryKitchen = [
    {
      "img": "image 41.png",
      "text": "Vegetables &\nFruits",
    },
    {
      "img": "image 42.png",
      "text": "Atta, Dal &\nRice",
    },
    {
      "img": "image 43.png",
      "text": "Oil, Ghee &\nMasala",
    },
    {
      "img": "image 44 (1).png",
      "text": "Dairy, Bread &\nMilk",
    },
    {
      "img": "image 45 (1).png",
      "text": "Biscuits &\nBakery",
    },
  ];

  List<Map<String, String>> filteredCategory = [];
  List<Map<String, String>> filteredGroceryKitchen = [];

  @override
  void initState() {
    super.initState();

    filteredCategory = List.from(category);
    filteredGroceryKitchen = List.from(groceryKitchen);

    searchController.addListener(searchProducts);
  }

  // ================= SEARCH =================

  void searchProducts() {
    final query = searchController.text.toLowerCase().trim();

    setState(() {
      if (query.isEmpty) {
        filteredCategory = List.from(category);
        filteredGroceryKitchen = List.from(groceryKitchen);
      } else {
        filteredCategory = category.where((item) {
          return item["text"]!.toLowerCase().contains(query);
        }).toList();

        filteredGroceryKitchen = groceryKitchen.where((item) {
          return item["text"]!.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  // ================= PRODUCT BUTTON =================

  Widget productButton(Map<String, String> product) {
    final id = product["id"]!;

    return AnimatedBuilder(
      animation: CartService.instance,
      builder: (context, child) {
        final quantity = CartService.instance.getQuantity(id);

        // ADD BUTTON
        if (quantity == 0) {
          return SizedBox(
            height: 30,
            child: UiHelper.CustomButton(() {
              CartService.instance.addItem(
                id: id,
                name: product["text"]!,
                image: product["img"]!,
                price: double.parse(product["price"]!),
              );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Product added to cart"),
                  duration: Duration(seconds: 1),
                ),
              );
            }),
          );
        }

        // QUANTITY BUTTON
        return Container(
          height: 28,
          width: 70,
          decoration: BoxDecoration(
            color: const Color(0XFF27AF34),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  CartService.instance.removeItem(id);
                },
                child: const Icon(
                  Icons.remove,
                  size: 16,
                  color: Colors.white,
                ),
              ),

              Text(
                quantity.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),

              InkWell(
                onTap: () {
                  CartService.instance.addItem(
                    id: id,
                    name: product["text"]!,
                    image: product["img"]!,
                    price: double.parse(product["price"]!),
                  );
                },
                child: const Icon(
                  Icons.add,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ================= CART BUTTON =================

  Widget cartButton() {
    return AnimatedBuilder(
      animation: CartService.instance,
      builder: (context, child) {
        final totalItems = CartService.instance.totalItems;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            );
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                  size: 20,
                ),
              ),

              if (totalItems > 0)
                Positioned(
                  right: -5,
                  top: -6,
                  child: Container(
                    height: 18,
                    width: 18,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        totalItems.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.removeListener(searchProducts);
    searchController.dispose();
    super.dispose();
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ==================================================
              // HEADER
              // ==================================================

              Stack(
                children: [
                  Container(
                    height: 190,
                    width: double.infinity,
                    color: const Color(0XFFEC0505),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 30,
                        right: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UiHelper.CustomText(
                            text: "Blinkit in",
                            color: Colors.white,
                            fontweight: FontWeight.bold,
                            fontsize: 15,
                            fontfamily: "bold",
                          ),

                          const SizedBox(height: 4),

                          UiHelper.CustomText(
                            text: "16 minutes",
                            color: Colors.white,
                            fontweight: FontWeight.bold,
                            fontsize: 20,
                            fontfamily: "bold",
                          ),

                          const SizedBox(height: 4),

                          Row(
                            children: [
                              UiHelper.CustomText(
                                text: "HOME ",
                                color: Colors.white,
                                fontweight: FontWeight.bold,
                                fontsize: 14,
                              ),

                              Expanded(
                                child: UiHelper.CustomText(
                                  text:
                                      "- Nandini, Mathura Road, Aligarh, Uttar Pradesh",
                                  color: Colors.white,
                                  fontweight: FontWeight.normal,
                                  fontsize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // PROFILE BUTTON

                  Positioned(
                    top: 25,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ProfileScreen(),
                          ),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),

                  // CART BUTTON

                  Positioned(
                    top: 25,
                    right: 65,
                    child: cartButton(),
                  ),

                  // SEARCH

                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 25,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SearchScreen(),
                          ),
                        );
                      },
                      child: AbsorbPointer(
                        child: UiHelper.CustomTextField(
                          controller: searchController,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // ==================================================
              // DIWALI SALE
              // ==================================================

              Container(
                height: 185,
                width: double.infinity,
                color: const Color(0XFFEC0505),
                child: Column(
                  children: [
                    const SizedBox(height: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UiHelper.CustomImage(
                          img: "image 60.png",
                        ),

                        UiHelper.CustomImage(
                          img: "image 55.png",
                        ),

                        const SizedBox(width: 5),

                        UiHelper.CustomText(
                          text: "Mega Diwali Sale",
                          color: Colors.white,
                          fontweight: FontWeight.bold,
                          fontsize: 20,
                          fontfamily: "bold",
                        ),

                        const SizedBox(width: 5),

                        UiHelper.CustomImage(
                          img: "image 55.png",
                        ),

                        UiHelper.CustomImage(
                          img: "image 61.png",
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      height: 105,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Container(
                              width: 90,
                              decoration: BoxDecoration(
                                color: const Color(0XFFEAD3D3),
                                borderRadius:
                                    BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 8),

                                  UiHelper.CustomText(
                                    text: data[index]["text"]!,
                                    color: Colors.black,
                                    fontweight: FontWeight.bold,
                                    fontsize: 10,
                                  ),

                                  SizedBox(
                                    height: 55,
                                    child: UiHelper.CustomImage(
                                      img: data[index]["img"]!,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // ==================================================
              // BESTSELLERS
              // ==================================================

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    UiHelper.CustomText(
                      text: "Bestsellers",
                      color: Colors.black,
                      fontweight: FontWeight.bold,
                      fontsize: 16,
                      fontfamily: "bold",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredCategory.length,
                  itemBuilder: (context, index) {
                    final product = filteredCategory[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: SizedBox(
                        width: 120,
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: const Color(0XFFF5F5F5),
                                borderRadius:
                                    BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(10),
                                child: UiHelper.CustomImage(
                                  img: product["img"]!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            const SizedBox(height: 7),

                            SizedBox(
                              height: 30,
                              child: UiHelper.CustomText(
                                text: product["text"]!,
                                color: Colors.black,
                                fontweight: FontWeight.bold,
                                fontsize: 10,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Row(
                              children: [
                                UiHelper.CustomImage(
                                  img: "timer 4.png",
                                ),

                                const SizedBox(width: 4),

                                UiHelper.CustomText(
                                  text: "16 MINS",
                                  color:
                                      const Color(0XFF9C9C9C),
                                  fontweight: FontWeight.normal,
                                  fontsize: 10,
                                ),
                              ],
                            ),

                            const SizedBox(height: 5),

                            Row(
                              children: [
                                UiHelper.CustomImage(
                                  img: "image 50 (1).png",
                                ),

                                const SizedBox(width: 4),

                                UiHelper.CustomText(
                                  text: "₹${product["price"]}",
                                  color: Colors.black,
                                  fontweight: FontWeight.bold,
                                  fontsize: 15,
                                ),

                                const Spacer(),

                                productButton(product),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 15),

              // ==================================================
              // GROCERY & KITCHEN
              // ==================================================

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    UiHelper.CustomText(
                      text: "Grocery & Kitchen",
                      color: Colors.black,
                      fontweight: FontWeight.bold,
                      fontsize: 16,
                      fontfamily: "bold",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredGroceryKitchen.length,
                  itemBuilder: (context, index) {
                    final product =
                        filteredGroceryKitchen[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: const Color(0XFFD9EBEB),
                              borderRadius:
                                  BorderRadius.circular(10),
                            ),
                            child: UiHelper.CustomImage(
                              img: product["img"]!,
                              fit: BoxFit.contain,
                            ),
                          ),

                          const SizedBox(height: 8),

                          UiHelper.CustomText(
                            text: product["text"]!,
                            color: Colors.black,
                            fontweight: FontWeight.normal,
                            fontsize: 10,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}