import 'package:blinkit_app/data/services/cart_services.dart';
import 'package:blinkit_app/data/services/order_services.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isLoading = false;

  Future<void> placeOrder() async {
    final cart = CartService.instance;

    // ================= CHECK CART =================

    if (cart.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Your cart is empty"),
        ),
      );
      return;
    }

    // ================= START LOADING =================

    setState(() {
      isLoading = true;
    });

    try {
      // ================= CONVERT CART ITEMS =================

      final orderItems = cart.items.map<OrderItem>((item) {
        return OrderItem(
          name: item.name,
          image: item.image,
          price: item.price,
          quantity: item.quantity,
        );
      }).toList();

      // ================= PLACE ORDER =================

      await OrderService.instance.placeOrder(
        items: orderItems,
        totalAmount: cart.totalPrice,
      );

      // ================= CLEAR CART =================

      cart.clearCart();

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      // ================= SUCCESS =================

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text(
              "Order Placed 🎉",
            ),
            content: const Text(
              "Your order has been placed successfully.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);

                  // Go back to cart/home
                  Navigator.pop(context);
                },
                child: const Text(
                  "Continue",
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      // ================= ERROR =================

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
          content: Text(
            "Failed to place order:\n$e",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartService.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0XFFF7CB45),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ================= ADDRESS =================

                    const Text(
                      "Delivery Address",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: const Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Home",
                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Nandini, Mathura Road, Aligarh, Uttar Pradesh",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ================= CART ITEMS =================

                    const Text(
                      "Order Items",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        children: cart.items.map((item) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(
                              bottom: 12,
                            ),
                            child: Row(
                              children: [

                                // PRODUCT IMAGE
                                Container(
                                  height: 65,
                                  width: 65,
                                  decoration:
                                      BoxDecoration(
                                    color: const Color(
                                      0XFFF5F5F5,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: Image.asset(
                                    "assets/images/${item.image}",
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (
                                      context,
                                      error,
                                      stackTrace,
                                    ) {
                                      return const Icon(
                                        Icons
                                            .image_not_supported,
                                        color: Colors.grey,
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // NAME + QUANTITY
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text(
                                        item.name,
                                        maxLines: 2,
                                        overflow:
                                            TextOverflow
                                                .ellipsis,
                                        style:
                                            const TextStyle(
                                          fontWeight:
                                              FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                          height: 5),
                                      Text(
                                        "Quantity: ${item.quantity}",
                                        style:
                                            const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // PRICE
                                Text(
                                  "₹${(item.price * item.quantity).toStringAsFixed(0)}",
                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ================= PAYMENT =================

                    const Text(
                      "Payment Method",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.money,
                            color: Colors.green,
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Cash on Delivery",
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ================= ORDER SUMMARY =================

                    const Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        children: [

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                            children: [
                              const Text("Items"),
                              Text(
                                "${cart.totalItems}",
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                            children: [
                              const Text("Subtotal"),
                              Text(
                                "₹${cart.totalPrice.toStringAsFixed(0)}",
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          const Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                            children: [
                              Text("Delivery Fee"),
                              Text(
                                "FREE",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const Divider(height: 25),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                            children: [
                              const Text(
                                "Total Amount",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                              Text(
                                "₹${cart.totalPrice.toStringAsFixed(0)}",
                                style:
                                    const TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // ================= PLACE ORDER =================

            Container(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0XFFE23744),
                  ),
                  onPressed:
                      isLoading ? null : placeOrder,
                  child: isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child:
                              CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Place Order • ₹${cart.totalPrice.toStringAsFixed(0)}",
                          style:
                              const TextStyle(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}