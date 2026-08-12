import 'package:blinkit_app/repository/widgets/uihelper.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> groceryKitchen = [
    {"img": "image 41.png", "text": "Vegetables &\nFruits"},
    {"img": "image 42.png", "text": "Atta, Dal &\nRice"},
    {"img": "image 43.png", "text": "Oil, Ghee &\nMasala"},
    {"img": "image 44 (1).png", "text": "Dairy, Bread &\nMilk"},
    {"img": "image 45 (1).png", "text": "Biscuits &\nBakery"},
  ];

  final List<Map<String, String>> secondGrocery = [
    {"img": "image 21.png", "text": "Dry Fruits &\nCereals"},
    {"img": "image 22.png", "text": "Kitchen &\nAppliances"},
    {"img": "image 23.png", "text": "Tea &\nCoffees"},
    {"img": "image 24.png", "text": "Ice Creams &\nmuch more"},
    {"img": "image 25.png", "text": "Noodles &\nPacket Food"},
  ];

  final List<Map<String, String>> snacksAndDrinks = [
    {"img": "image 31.png", "text": "Chips &\nNamkeens"},
    {"img": "image 32.png", "text": "Sweets &\nChocolates"},
    {"img": "image 33.png", "text": "Drinks &\nJuices"},
    {"img": "image 34.png", "text": "Sauces &\nSpreads"},
    {"img": "image 35.png", "text": "Beauty &\nCosmetics"},
  ];

  final List<Map<String, String>> household = [
    {"img": "image 36.png"},
    {"img": "image 37.png"},
    {"img": "image 38.png"},
    {"img": "image 39.png"},
    {"img": "image 40.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Header
            Stack(
              children: [
                Container(
                  height: 190,
                  width: double.infinity,
                  color: const Color(0XFFF7CB45),
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
                          color: Colors.black,
                          fontweight: FontWeight.bold,
                          fontsize: 15,
                          fontfamily: "bold",
                        ),
                        const SizedBox(height: 4),
                        UiHelper.CustomText(
                          text: "16 minutes",
                          color: Colors.black,
                          fontweight: FontWeight.bold,
                          fontsize: 20,
                          fontfamily: "bold",
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            UiHelper.CustomText(
                              text: "HOME ",
                              color: Colors.black,
                              fontweight: FontWeight.bold,
                              fontsize: 14,
                            ),
                            Expanded(
                              child: UiHelper.CustomText(
                                text:
                                    "- Nandini, mathura road, aligarh, uttar pradesh, 202001",
                                color: Colors.black,
                                fontweight: FontWeight.bold,
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
                  right: 20,
                  top: 25,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 20,
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

            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Grocery & Kitchen
                    sectionTitle("Grocery & Kitchen"),

                    categoryRow(groceryKitchen),

                    categoryRow(secondGrocery),

                    // Snacks & Drinks
                    sectionTitle("Snacks & Drinks"),

                    categoryRow(snacksAndDrinks),

                    const SizedBox(height: 20),

                    // Household
                    sectionTitle("Household Essentials"),

                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: household.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Container(
                              height: 78,
                              width: 71,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0XFFD9EBEB),
                              ),
                              child: UiHelper.CustomImage(
                                img: household[index]["img"]!,
                              ),
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
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        bottom: 10,
      ),
      child: Row(
        children: [
          UiHelper.CustomText(
            text: title,
            color: Colors.black,
            fontweight: FontWeight.bold,
            fontsize: 14,
            fontfamily: "bold",
          ),
        ],
      ),
    );
  }

  Widget categoryRow(List<Map<String, String>> items) {
    return SizedBox(
      height: 125,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: SizedBox(
              width: 80,
              child: Column(
                children: [
                  Container(
                    height: 78,
                    width: 71,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0XFFD9EBEB),
                    ),
                    child: UiHelper.CustomImage(
                      img: items[index]["img"]!,
                    ),
                  ),

                  const SizedBox(height: 5),

                  UiHelper.CustomText(
                    text: items[index]["text"]!,
                    color: Colors.black,
                    fontweight: FontWeight.normal,
                    fontsize: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}