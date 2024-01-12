import 'package:flutter/material.dart';
import 'package:student_uni_services2/size_config.dart';

Container circleContainer(double height) {
  return Container(
    height: height * 0.4,
    decoration: const BoxDecoration(
      color: Color(0xff23B1AD),
      borderRadius: BorderRadius.vertical(
        bottom: Radius.elliptical(175, 80),
      ),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          margin:
              const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 0),
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenHeight(30),
          ),
        ),
      ],
    ),
  );
}
