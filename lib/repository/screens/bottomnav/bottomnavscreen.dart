import 'package:blinkit_app/repository/screens/cart/cartscreen.dart';
import 'package:blinkit_app/repository/screens/category/categoryscreen.dart';
import 'package:blinkit_app/repository/screens/home/homescreen.dart';
import 'package:blinkit_app/repository/screens/print/printscreen.dart';
import 'package:blinkit_app/repository/widgets/uihelper.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomeScreen(),
    CartScreen(),
    CategoryScreen(),
    PrintScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: const Color(0XFFE23744),
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
            icon: Image.asset(
              "assets/images/home 1.png",
              height: 24,
              width: 24,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: UiHelper.CustomImage(
              img: "shopping-bag 1.png",
              height: 24,
              width: 24,
            ),
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