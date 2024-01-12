import 'package:flutter/material.dart';
import 'package:student_uni_services2/Screens/Abstracts/components/Abstracts_List.dart';
import 'package:student_uni_services2/size_config.dart';

class AbstractsScreen extends StatelessWidget {
  static String routeName = "/abstracts";

  const AbstractsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      backgroundColor: Color(0xFF297C74),
      body: AbstractListScreen(),
    );
  }
}
