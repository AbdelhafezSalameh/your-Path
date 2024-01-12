// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:student_uni_services2/Screens/home/home_screen.dart';
// import 'package:student_uni_services2/Screens/profile/profile_screen.dart';
// import 'package:student_uni_services2/To-Do/app/app.dart';

// class ExampleNvbar extends StatefulWidget {
//   ExampleNvbar({required this.index, super.key});
//   int index;
//   @override
//   _ExampleNvbarState createState() => _ExampleNvbarState();
// }

// class _ExampleNvbarState extends State<ExampleNvbar> {
//   late int selectedIndex = widget.index;
//   static TextStyle optionStyle =
//       TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
//   static final List<Widget> _widgetOptions = <Widget>[
//     HomeScreen(),
//     //UniversityScreen(),
//     const FlutterRiverpodTodoApp(),
//     // Scaffold(),
//     ProfileScreen()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF297C74),
//       body: Center(
//         child: _widgetOptions.elementAt(selectedIndex),
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Color(0XFF23B1AD),
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 20,
//               color: Colors.black.withOpacity(.1),
//             )
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//             child: GNav(
//               // rippleColor: Colors.grey[300]!,
//               // hoverColor: Colors.grey[100]!,
//               rippleColor: Color(0xFF30D7BB),
//               hoverColor: Color(0xFF30D7BB),
//               gap: 8,
//               activeColor: Colors.black,
//               iconSize: 24,
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               duration: Duration(milliseconds: 400),
//               tabBackgroundColor: Color(0xFF30D7BB),
//               color: Colors.black,
//               tabs: const [
//                 GButton(
//                   icon: LineIcons.home,
//                   text: 'Home',
//                 ),
//                 GButton(
//                   icon: LineIcons.university,
//                   text: 'University',
//                 ),
//                 GButton(
//                   icon: LineIcons.tasks,
//                   text: 'To-Do',
//                 ),
//                 GButton(
//                   icon: LineIcons.user,
//                   text: 'Profile',
//                 ),
//               ],
//               selectedIndex: selectedIndex,
//               onTabChange: (index) {
//                 setState(() {
//                   selectedIndex = index;
//                 });
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
