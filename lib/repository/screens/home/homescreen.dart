
import 'package:blinkit_app/data/services/cart_services.dart';
import 'package:blinkit_app/repository/widgets/uihelper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  final CartService cartService = CartService.instance;

  final List<Map<String, String>> data = [
    {"img": "image 50.png", "text": "Lights, Diyas\n& Candles"},
    {"img": "image 51.png", "text": "Diwali\nGifts"},
    {"img": "image 52.png", "text": "Appliances\n& Gadgets"},
    {"img": "image 53.png", "text": "Home\n& Living"},
  ];

  final List<Map<String, String>> category = [
    {
      "img": "image 54.png",
      "text": "Golden Glass\nWooden Lid Candle (Oudh)"
    },
    {
      "img": "image 57.png",
      "text": "Royal Gulab Jamun\nBy Bikano"
    },
    {
      "img": "image 63.png",
      "text": "Golden Glass\nWooden Lid Candle (Oudh)"
    },
  ];

  final List<Map<String, String>> groceryKitchen = [
    {"img": "image 41.png", "text": "Vegetables &\nFruits"},
    {"img": "image 42.png", "text": "Atta, Dal &\nRice"},
    {"img": "image 43.png", "text": "Oil, Ghee &\nMasala"},
    {"img": "image 44 (1).png", "text": "Dairy, Bread &\nMilk"},
    {"img": "image 45 (1).png", "text": "Biscuits &\nBakery"},
  ];

  @override
  void initState() {
    super.initState();

    cartService.addListener(_cartUpdated);
  }

  void _cartUpdated() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    cartService.removeListener(_cartUpdated);
    searchController.dispose();
    super.dispose();
  }

  Widget productButton(int index) {
    final quantity = cartService.items[index].quantity;

    if (quantity == 0) {
      return UiHelper.CustomButton(() {
        cartService.addItem(index);
      });
    }

    return Container(
      height: 24,
      width: 65,
      decoration: BoxDecoration(
        color: const Color(0XFF27AF34),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              cartService.removeItem(index);
            },
            child: const Icon(
              Icons.remove,
              size: 15,
              color: Colors.white,
            ),
          ),
          Text(
            quantity.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () {
              cartService.addItem(index);
            },
            child: const Icon(
              Icons.add,
              size: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
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
                                      "- Sujal Dave, Ratanada, Jodhpur (Raj)",
                                  color: Colors.white,
                                  fontweight: FontWeight.normal,
                                  fontsize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Positioned(
                    top: 25,
                    right: 20,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 25,
                    child: UiHelper.CustomTextField(
                      controller: searchController,
                    ),
                  ),
                ],
              ),

              // DIWALI SALE
              Container(
                height: 165,
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
                                borderRadius: BorderRadius.circular(10),
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

              // BESTSELLERS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
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
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: SizedBox(
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: const Color(0XFFF5F5F5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: UiHelper.CustomImage(
                                  img: category[index]["img"]!,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            UiHelper.CustomText(
                              text: category[index]["text"]!,
                              color: Colors.black,
                              fontweight: FontWeight.bold,
                              fontsize: 10,
                            ),

                            const SizedBox(height: 6),

                            Row(
                              children: [
                                UiHelper.CustomImage(
                                  img: "timer 4.png",
                                ),

                                const SizedBox(width: 4),

                                UiHelper.CustomText(
                                  text: "16 MINS",
                                  color: const Color(0XFF9C9C9C),
                                  fontweight: FontWeight.normal,
                                  fontsize: 10,
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            Row(
                              children: [
                                UiHelper.CustomImage(
                                  img: "image 50 (1).png",
                                ),

                                const SizedBox(width: 4),

                                UiHelper.CustomText(
                                  text: "₹79",
                                  color: Colors.black,
                                  fontweight: FontWeight.bold,
                                  fontsize: 15,
                                ),

                                const Spacer(),

                                productButton(index),
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

              // GROCERY & KITCHEN
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
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
                  itemCount: groceryKitchen.length,
                  itemBuilder: (context, index) {
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: UiHelper.CustomImage(
                              img: groceryKitchen[index]["img"]!,
                            ),
                          ),

                          const SizedBox(height: 8),

                          UiHelper.CustomText(
                            text: groceryKitchen[index]["text"]!,
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