import 'package:blinkit_app/data/services/cart_services.dart';
import 'package:blinkit_app/repository/screens/cart/cartscreen.dart';
import 'package:blinkit_app/repository/screens/category/categoryscreen.dart';
import 'package:blinkit_app/repository/screens/home/homescreen.dart';
import 'package:blinkit_app/repository/screens/print/printscreen.dart';
import 'package:blinkit_app/repository/widgets/uihelper.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() =>
      _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentIndex = 0;

  final CartService cartService = CartService.instance;

  final List<Widget> pages = [
     HomeScreen(),
     CartScreen(),
     CategoryScreen(),
     PrintScreen(),
  ];

  @override
  void initState() {
    super.initState();
    cartService.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    cartService.removeListener(_refresh);
    super.dispose();
  }

  Widget cartIcon() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        UiHelper.CustomImage(
          img: "shopping-bag 1.png",
          height: 24,
          width: 24,
        ),

        if (cartService.totalItems > 0)
          Positioned(
            right: -8,
            top: -8,
            child: Container(
              height: 18,
              width: 18,
              decoration: const BoxDecoration(
                color: Color(0XFFE23744),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  cartService.totalItems > 99
                      ? "99+"
                      : cartService.totalItems.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar:
          BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor:
            const Color(0XFFE23744),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: UiHelper.CustomImage(
              img: "home 1.png",
              height: 24,
              width: 24,
            ),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: cartIcon(),
            label: "Cart",
          ),

          BottomNavigationBarItem(
            icon: UiHelper.CustomImage(
              img: "category 1.png",
              height: 24,
              width: 24,
            ),
            label: "Categories",
          ),

          BottomNavigationBarItem(
            icon: UiHelper.CustomImage(
              img: "printer 1.png",
              height: 24,
              width: 24,
            ),
            label: "Print",
          ),
        ],
      ),
    );
  }
}