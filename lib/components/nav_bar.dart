import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:student_uni_services2/Screens/university/TabBar.dart';
import 'package:student_uni_services2/Screens/home/home_screen.dart';
import 'package:student_uni_services2/Screens/profile/profile_screen.dart';
import 'package:student_uni_services2/To-Do/app/app.dart';
import 'package:student_uni_services2/generated/l10n.dart';
import 'package:student_uni_services2/size_config.dart';

void main() => runApp(MaterialApp(
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: child!,
        );
      },
      title: 'GNav',
      theme: ThemeData(
        primaryColor: Colors.grey[800],
      ),
      home: const Example(),
    ));

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  ExampleState createState() => ExampleState();
}

class ExampleState extends State<Example> {
  int selectedIndex = 0;

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
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(15),
                vertical: getProportionateScreenHeight(8)),
            child: GNav(
              rippleColor: const Color(0xFF30D7BB),
              hoverColor: const Color(0xFF30D7BB),
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(12)),
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

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const Tab_Bar(),
    const FlutterRiverpodTodoApp(),
    const ProfileScreen(),
  ];
}
