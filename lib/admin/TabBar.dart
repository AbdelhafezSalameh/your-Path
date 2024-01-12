import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_uni_services2/Screens/splash/splash_screen.dart';
import 'package:student_uni_services2/admin/abstracts_requests.dart';
import 'package:student_uni_services2/admin/add_university_info.dart';
import 'package:student_uni_services2/admin/book_requests.dart';
import 'package:student_uni_services2/admin/houses_requests.dart';
import 'package:student_uni_services2/size_config.dart';

// ignore: camel_case_types
class Admin_Tab_Bar extends StatefulWidget {
  static String routeName = "/AdminScreen";

  const Admin_Tab_Bar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Admin_Tab_BarState createState() => _Admin_Tab_BarState();
}

// ignore: camel_case_types
class _Admin_Tab_BarState extends State<Admin_Tab_Bar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                'Welcome, Administrator!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: const Color(0xFF297C74),
              centerTitle: true,
              //toolbarHeight: getProportionateScreenHeight(90),
              elevation: 0,
              bottom: TabBar(
                  isScrollable: true,
                  labelPadding: const EdgeInsets.all(0),
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF30D7BB)),
                  padding: EdgeInsets.only(
                    bottom: getProportionateScreenHeight(10),
                    top: getProportionateScreenHeight(20),
                  ),
                  tabs: [
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(10),
                            vertical: getProportionateScreenWidth(5)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Books Requests",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(20),
                            vertical: getProportionateScreenWidth(10)),
                        child: const Text(
                          "Abstracts Requests",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(20),
                            vertical: getProportionateScreenWidth(10)),
                        child: const Text(
                          "Houses Requests",
                          style: TextStyle(
                            fontSize: 16, // Adjust the font size as needed
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(20),
                            vertical: getProportionateScreenWidth(10)),
                        child: const Text(
                          "University information",
                          style: TextStyle(
                            fontSize: 16, // Adjust the font size as needed
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            body: Stack(children: [
              const TabBarView(
                children: [
                  BookRequests(),
                  AbstractsRequests(),
                  HousesRequests(),
                  AddUniversityInformation(),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushNamed(context, SplashScreen.routeName);
                    },
                    label: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
