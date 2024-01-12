// ignore: file_names
import 'package:flutter/material.dart';
import 'package:student_uni_services2/Screens/exchange%20books/components/Book_List.dart';
import 'package:student_uni_services2/size_config.dart';

class BookExchangeScreen extends StatelessWidget {
  static String routeName = "/BookExchange";

  const BookExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return const Scaffold(
        backgroundColor: Color(0xFF297C74), body: BookListScreen());
  }
}
