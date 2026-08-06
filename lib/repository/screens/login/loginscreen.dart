import 'package:blinkit_app/data/services/auth_service.dart';
import 'package:blinkit_app/repository/screens/auth/otpscreen.dart';
import 'package:blinkit_app/repository/widgets/uihelper.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              UiHelper.CustomImage(
                img: "Blinkit Onboarding Screen.png",
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 20),

              UiHelper.CustomImage(img: "image 10.png", height: 70),

              const SizedBox(height: 10),

              UiHelper.CustomText(
                text: "India's last minute app",
                color: Colors.black,
                fontweight: FontWeight.bold,
                fontsize: 20,
                fontfamily: "bold",
              ),

              const SizedBox(height: 25),

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
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Phone Number",
                            prefixText: "+91 ",
                          ),
                        ),

                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0XFFE23744),
                            ),
                            onPressed: () async {
                              if (phoneController.text.length != 10) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Enter a valid phone number"),
                                  ),
                                );
                                return;
                              }

                              setState(() {
                                isLoading = true;
                              });

                              await AuthService().verifyPhone(
                                phoneNumber: phoneController.text.trim(),
                                codeSent: (verificationId) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => OtpScreen(
                                        verificationId: verificationId,
                                      ),
                                    ),
                                  );
                                },
                                failed: (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                },
                              );

                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Send OTP",
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
