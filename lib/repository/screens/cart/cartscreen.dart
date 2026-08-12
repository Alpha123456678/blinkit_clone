import 'package:blinkit_app/data/services/cart_services.dart';
import 'package:blinkit_app/repository/screens/checkout/checkoutscreen.dart';
import 'package:blinkit_app/repository/widgets/uihelper.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    CartService.instance.addListener(cartUpdated);
  }

  void cartUpdated() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    CartService.instance.removeListener(cartUpdated);
    searchController.dispose();
    super.dispose();
  }

  Widget quantityButton(CartItem item) {
    return Container(
      height: 30,
      width: 75,
      decoration: BoxDecoration(
        color: const Color(0XFF27AF34),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              CartService.instance.removeItem(item.id);
            },
            child: const Icon(Icons.remove, color: Colors.white, size: 16),
          ),

          Text(
            item.quantity.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),

          InkWell(
            onTap: () {
              CartService.instance.addItem(
                id: item.id,
                name: item.name,
                image: item.image,
                price: item.price,
              );
            },
            child: const Icon(Icons.add, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartService.instance;
    final List<CartItem> items = cart.items;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
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
                      right: 20,
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

                        UiHelper.CustomText(
                          text: "HOME - Nandini, Mathura Road, Aligarh",
                          color: Colors.black,
                          fontweight: FontWeight.bold,
                          fontsize: 13,
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
                    child: Icon(Icons.person, color: Colors.black, size: 20),
                  ),
                ),

                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 25,
                  child: UiHelper.CustomTextField(controller: searchController),
                ),
              ],
            ),

            // ================= CART =================
            Expanded(
              child: items.isEmpty
                  ? emptyCart()
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 15, 16, 5),
                          child: Row(
                            children: [
                              Text(
                                "My Cart",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const Spacer(),

                              Text(
                                "${cart.totalItems} items",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(15),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        color: const Color(0XFFF5F5F5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: UiHelper.CustomImage(
                                        img: item.image,
                                        fit: BoxFit.contain,
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),

                                          const SizedBox(height: 7),

                                          Text(
                                            "₹${item.price.toStringAsFixed(0)}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    quantityButton(item),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        // ================= TOTAL =================
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Subtotal",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "₹${cart.totalPrice.toStringAsFixed(0)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Delivery Fee",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "FREE",
                                    style: TextStyle(
                                      color: Color(0XFF27AF34),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const Divider(height: 20),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Total",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "₹${cart.totalPrice.toStringAsFixed(0)}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0XFFE23744),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CheckoutScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Proceed to Checkout",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.CustomImage(img: "cart.png", height: 150),

            const SizedBox(height: 20),

            UiHelper.CustomText(
              text: "Your cart is empty",
              color: Colors.black,
              fontweight: FontWeight.bold,
              fontsize: 18,
              fontfamily: "bold",
            ),

            const SizedBox(height: 8),

            const Text(
              "Add products from Home to see them here.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
