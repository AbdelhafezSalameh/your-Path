import 'package:flutter/material.dart';
import 'package:student_uni_services2/screens/splash/components/body.dart';
import 'package:student_uni_services2/size_config.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  int currentPage = 0;

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}
