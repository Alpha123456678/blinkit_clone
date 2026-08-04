import 'package:blinkit_app/repository/screens/bottomnav/bottomnavscreen.dart';
import 'package:blinkit_app/repository/widgets/uihelper.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UiHelper.CustomImage(
                img: "Blinkit Onboarding Screen.png",
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 15),

              UiHelper.CustomImage(
                img: "image 10.png",
                height: 70,
              ),

              const SizedBox(height: 10),

              UiHelper.CustomText(
                text: "India's last minute app",
                color: Colors.black,
                fontweight: FontWeight.bold,
                fontsize: 20,
                fontfamily: "bold",
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        UiHelper.CustomText(
                          text: "Sujal",
                          color: Colors.black,
                          fontweight: FontWeight.w600,
                          fontsize: 16,
                        ),

                        const SizedBox(height: 5),

                        UiHelper.CustomText(
                          text: "78277XXXX",
                          color: Colors.grey,
                          fontweight: FontWeight.bold,
                          fontsize: 14,
                          fontfamily: "bold",
                        ),

                        const SizedBox(height: 20),

                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BottomNavScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0XFFE23744),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                UiHelper.CustomText(
                                  text: "Login with",
                                  color: Colors.white,
                                  fontweight: FontWeight.bold,
                                  fontsize: 14,
                                  fontfamily: "bold",
                                ),
                                const SizedBox(width: 8),
                                UiHelper.CustomImage(
                                  img: "image 9.png",
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        UiHelper.CustomText(
                          text:
                              "Access your saved addresses from Zomato automatically!",
                          color: Colors.grey,
                          fontweight: FontWeight.normal,
                          fontsize: 10,
                        ),

                        const SizedBox(height: 12),

                        UiHelper.CustomText(
                          text: "or login with phone number",
                          color: const Color(0XFF269237),
                          fontweight: FontWeight.w500,
                          fontsize: 14,
                        ),
                      ],
                    ),
                  ),
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