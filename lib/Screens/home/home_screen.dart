import 'package:flutter/material.dart';
import 'package:student_uni_services2/Screens/home/components/home_header.dart';
import 'package:student_uni_services2/size_config.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      backgroundColor: Color(0xFF297C74),
      body: HomeHeader(),
    );
  }
}
