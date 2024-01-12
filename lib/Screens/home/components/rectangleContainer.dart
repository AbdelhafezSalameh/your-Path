import 'package:flutter/material.dart';
import 'package:student_uni_services2/Screens/exchange%20books/Book%20Exchange.dart';
import 'package:student_uni_services2/Screens/houses%20Screen/houses_Screen.dart';
import 'package:student_uni_services2/Screens/Abstracts/Abstract_Screen.dart';
import 'package:student_uni_services2/Screens/university/Ads/Ads.dart';
import 'package:student_uni_services2/Screens/profile/profile_screen.dart';
import 'package:student_uni_services2/To-Do/app/app.dart';

Padding rectangleContainer(double height, double width, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 180, left: 15, right: 15, bottom: 10),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff23B1AD),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 3,
            offset: const Offset(0, 3), // شادو
          ),
        ],
      ),
      height: height * 0.35,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  // acadmic icon and containor
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => Example(
                      //         index: 1,
                      //       ),
                      //     ));
                      //  setState(() {});
                      Navigator.pushNamed(context, AbstractsScreen.routeName);
                    },
                    child: Container(
                      height: height * 0.1,
                      width: width * 0.18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF30D7BB),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // الشادو
                          ),
                        ],
                      ),
                      child: Image.asset(
                        //   color: Colors.white,
                        'assets/images/acadmic02.png',
                      ),
                    ),
                  ),
                  // acadmic text
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const Text(
                    "Abstracts",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const Calender(),
                      //     ));
                      Navigator.pushNamed(
                          context, BookExchangeScreen.routeName);
                    },
                    child: Container(
                      height: height * 0.1,
                      width: width * 0.18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF30D7BB),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // شادو
                          ),
                        ],
                      ),
                      child: Image.asset(
                        //  color: Colors.white,
                        'assets/images/exchange Book.png',
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const Text("Exchange Book",
                      style: TextStyle(color: Colors.white))
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FlutterRiverpodTodoApp(),
                          ));
                    },
                    child: Container(
                      height: height * 0.1,
                      width: width * 0.18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF30D7BB),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // شادو
                          ),
                        ],
                      ),
                      child: Image.asset(
                        //  color: Colors.white,
                        'assets/images/toDo02.png',
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: const Text("To-Do List",
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdsScreen(),
                        ));
                  },
                  child: Container(
                    height: height * 0.1,
                    width: width * 0.18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF30D7BB),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // شادو
                        ),
                      ],
                    ),
                    child: Image.asset(
                      //    color: Colors.white,
                      'assets/images/ads02.png',
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                const Text("Ads", style: TextStyle(color: Colors.white))
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ));
                  },
                  child: Container(
                    height: height * 0.1,
                    width: width * 0.18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF30D7BB),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // شادو
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/profile02.png',
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                const Text("Profile", style: TextStyle(color: Colors.white))
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, HousesScreen.routeName);
                  },
                  child: Container(
                    height: height * 0.1,
                    width: width * 0.18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF30D7BB),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // شادو
                        ),
                      ],
                    ),
                    child: Image.asset(
                      fit: BoxFit.contain,
                      'assets/images/houses2.png',
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                const Text("Houses", style: TextStyle(color: Colors.white)),
              ],
            ),
          ]),
        ],
      ),
    ),
  );
}
