import 'package:flutter/material.dart';

class UiHelper {
  static Image CustomImage({
    required String img,
    double? height,
    double? width,
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.asset(
      "assets/images/$img",
      height: height,
      width: width,
      fit: fit,
    );
  }

  static Text CustomText({
    required String text,
    required Color color,
    required FontWeight fontweight,
    String? fontfamily,
    required double fontsize,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontsize,
        fontFamily: fontfamily ?? "regular",
        fontWeight: fontweight,
        color: color,
      ),
    );
  }

  static Widget CustomTextField({
    required TextEditingController controller,
  }) {
    return Container(
      height: 45,
      width: 360,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0XFFC5C5C5),
        ),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          hintText: "Search 'ice-cream'",
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              "assets/images/search.png",
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              "assets/images/mic 1.png",
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  static Widget CustomButton(VoidCallback callback) {
    return InkWell(
      onTap: callback,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: 24,
        width: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0XFF27AF34),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Center(
          child: Text(
            "ADD",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0XFF27AF34),
            ),
          ),
        ),
      ),
    );
  }
}