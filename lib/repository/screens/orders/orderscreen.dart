
import 'package:blinkit_app/data/services/order_services.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    OrderService.instance.addListener(orderUpdated);
  }

  void orderUpdated() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    OrderService.instance.removeListener(orderUpdated);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orders = OrderService.instance.orders;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Orders",
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
      body: orders.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "No orders yet",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Your placed orders will appear here.",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return Container(
                  margin:
                      const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Order",
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "₹${order.totalAmount.toStringAsFixed(0)}",
                            style: const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      Text(
                        order.orderId,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),

                      const Divider(height: 20),

                      ...order.items.map(
                        (item) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 55,
                                  width: 55,
                                  decoration:
                                      BoxDecoration(
                                    color:
                                        const Color(
                                      0XFFF5F5F5,
                                    ),
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      8,
                                    ),
                                  ),
                                  child: Image.asset(
                                    "assets/images/${item.image}",
                                    fit: BoxFit.contain,
                                  ),
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: Text(
                                    item.name,
                                    maxLines: 2,
                                    overflow:
                                        TextOverflow
                                            .ellipsis,
                                    style:
                                        const TextStyle(
                                      fontWeight:
                                          FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),

                                Text(
                                  "x${item.quantity}",
                                  style:
                                      const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 5),

                      const Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Order placed successfully",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}