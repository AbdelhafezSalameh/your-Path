import 'package:flutter/material.dart';
import 'package:student_uni_services2/Screens/university/Calander/Calander.dart';
import 'package:student_uni_services2/Screens/university/Events/Events.dart';
import 'package:student_uni_services2/Screens/university/News/News.dart';
import 'package:student_uni_services2/size_config.dart';

// ignore: camel_case_types
class Tab_Bar extends StatefulWidget {
  static String routeName = "/SummaryList";

  const Tab_Bar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Tab_BarState createState() => _Tab_BarState();
}

// ignore: camel_case_types
class _Tab_BarState extends State<Tab_Bar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                // ignore: avoid_unnecessary_containers
                title: Container(
                  child: Text(
                    'University',
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(22),
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                centerTitle: true,
                backgroundColor: const Color(0xFF297C74),
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
                        top: getProportionateScreenHeight(20)),
                    tabs: [
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenHeight(20),
                              vertical: getProportionateScreenWidth(10)),
                          child: const Text(
                            "News",
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
                            "Events",
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
                            "Calander",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              body: const TabBarView(
                children: [
                  NewsScreen(),
                  EventsScreen(),
                  CalanderScreen(),
                ],
              ),
            ),
          ),
        ));
  }
}
