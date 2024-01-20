import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_uni_services2/Screens/home/components/brakingNews.dart';
import 'package:student_uni_services2/Screens/home/components/circleContainer.dart';
import 'package:student_uni_services2/Screens/home/components/rectangleContainer.dart';
import 'package:student_uni_services2/generated/l10n.dart';
import '../../../size_config.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  File? image;
  late String fullName = '';

  @override
  void initState() {
    super.initState();
    fetchUserDataFromFirestore();
  }

  Future<void> fetchUserDataFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          setState(() {
            fullName = snapshot.get('fullName') ?? '';
          });
        }
      } catch (e) {
        // ignore: avoid_print
        print('Error fetching user data from Firestore: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Stack(
          children: [
            circleContainer(height),
            header(),
            rectangleContainer(height, width, context),
          ],
        ),
        brakingNews(),
      ],
    );
  }

  SafeArea header() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25), // title
        child: Text.rich(
          TextSpan(
            style: const TextStyle(color: Colors.white),
            children: [
              TextSpan(
                text: S.of(context).home_welcome,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: " $fullName \n",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(22),
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: S.of(context).home_title,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
