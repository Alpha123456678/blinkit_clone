
import 'package:blinkit_app/data/services/cart_services.dart';
import 'package:blinkit_app/repository/widgets/uihelper.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController searchController = TextEditingController();

  final CartService cartService = CartService.instance;

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
    final item = cartService.items[index];

    if (item.quantity == 0) {
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
              color: Colors.white,
              size: 15,
            ),
          ),
          Text(
            item.quantity.toString(),
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
              color: Colors.white,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget cartProductCard(int index) {
    final item = cartService.items[index];

    return SizedBox(
      width: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
              color: const Color(0XFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: UiHelper.CustomImage(
              img: item.image,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            item.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Row(
            children: [
              const Icon(
                Icons.timer_outlined,
                size: 12,
                color: Color(0XFF9C9C9C),
              ),
              const SizedBox(width: 3),
              const Text(
                "16 MINS",
                style: TextStyle(
                  fontSize: 9,
                  color: Color(0XFF9C9C9C),
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Row(
            children: [
              Text(
                "₹${item.price}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              productButton(index),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalItems = cartService.totalItems;
    final totalPrice = cartService.totalPrice;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),

              // HEADER
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
                                      "- Sujal Dave, Ratanada, Jodhpur (Raj)",
                                  color: Colors.black,
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

              // CART IMAGE
              UiHelper.CustomImage(
                img: "cart.png",
                height: 150,
              ),

              const SizedBox(height: 15),

              UiHelper.CustomText(
                text: "Reordering will be easy",
                color: Colors.black,
                fontweight: FontWeight.bold,
                fontsize: 16,
                fontfamily: "bold",
              ),

              const SizedBox(height: 5),

              UiHelper.CustomText(
                text:
                    "Items you order will show up here so you can buy",
                color: Colors.black,
                fontweight: FontWeight.normal,
                fontsize: 12,
              ),

              UiHelper.CustomText(
                text: "them again easily.",
                color: Colors.black,
                fontweight: FontWeight.normal,
                fontsize: 12,
              ),

              const SizedBox(height: 25),

              // CART SUMMARY
              if (totalItems > 0)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0XFFF5F5F5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        color: Color(0XFF27AF34),
                      ),

                      const SizedBox(width: 10),

                      Text(
                        "$totalItems item${totalItems > 1 ? 's' : ''} in cart",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      Text(
                        "₹$totalPrice",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 25),

              // BESTSELLERS
              Row(
                children: [
                  const SizedBox(width: 20),
                  UiHelper.CustomText(
                    text: "Bestsellers",
                    color: Colors.black,
                    fontweight: FontWeight.bold,
                    fontsize: 16,
                    fontfamily: "bold",
                  ),
                ],
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20),
                  itemCount: cartService.items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: cartProductCard(index),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // VIEW CART BUTTON
              if (totalItems > 0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "$totalItems items • Total ₹$totalPrice",
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF27AF34),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Proceed • ₹$totalPrice",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}