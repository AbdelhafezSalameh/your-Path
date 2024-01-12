import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:student_uni_services2/Screens/university/TabBar.dart';
import 'package:student_uni_services2/Screens/home/home_screen.dart';
import 'package:student_uni_services2/Screens/profile/profile_screen.dart';
import 'package:student_uni_services2/To-Do/app/app.dart';
import 'package:student_uni_services2/generated/l10n.dart';

void main() => runApp(MaterialApp(
    builder: (context, child) {
      return Directionality(textDirection: TextDirection.ltr, child: child!);
    },
    title: 'GNav',
    theme: ThemeData(
      primaryColor: Colors.grey[800],
    ),
    home: const Example()));

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  ExampleState createState() => ExampleState();
}

int selectedIndex = 0;

class ExampleState extends State<Example> {
  static TextStyle optionStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const Tab_Bar(),
    const FlutterRiverpodTodoApp(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF297C74),
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0XFF23B1AD),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              // rippleColor: Colors.grey[300]!,
              // hoverColor: Colors.grey[100]!,
              rippleColor: const Color(0xFF30D7BB),
              hoverColor: const Color(0xFF30D7BB),
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: const Color(0xFF30D7BB),
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: S.of(context).navBar_home,
                ),
                const GButton(
                  icon: LineIcons.university,
                  text: 'University',
                ),
                const GButton(
                  icon: LineIcons.tasks,
                  text: 'To-Do',
                ),
                const GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
