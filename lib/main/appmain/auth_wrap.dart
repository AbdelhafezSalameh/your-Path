import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_uni_services2/Screens/sign_in/components/sign_form.dart';
import 'package:student_uni_services2/Screens/splash/splash_screen.dart';
import 'package:student_uni_services2/admin/homeScreen.dart';
import 'package:student_uni_services2/advertiser_home/advertiserHomeScreen.dart';
import 'package:student_uni_services2/components/nav_bar.dart';

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});
//   static String routeName = "/AuthWrapper";

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else if (snapshot.hasData) {
//           return const Example();
//         } else {
//           return SplashScreen();
//         }
//       },
//     );
//   }
// }

class AuthWrapper extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AuthWrapper({Key? key});

  static String routeName = "/AuthWrapper";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          // التسجيل ك طالب
          return FutureBuilder<String?>(
            future: getUserRole(FirebaseAuth.instance.currentUser?.uid ?? ""),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                final String? userRole = roleSnapshot.data;

                if (userRole == 'student') {
                  return const Example();
                } else if (userRole == 'advertiser') {
                  return const AdvertiserHomeScreen();
                } else if (userRole == 'admin') {
                  return const HomeScreenAdmin();
                } else {
                  // اذا ما كان معروف اذا هو طالب او معلن
                  // ignore: avoid_print
                  print('Unknown user role: $userRole');
                  return SplashScreen();
                }
              }
            },
          );
        } else {
          return SplashScreen();
        }
      },
    );
  }
}








  // Future<void> logIn(String email, String password) async {
  //   String? result = await _auth.signIn(email, password);

  //   if (result == null) {
  //     User? user = FirebaseAuth.instance.currentUser;

  //     if (user != null) {
  //       String? userRole = await getUserRole(user.uid);

  //       if (userRole == 'Student') {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => Example()),
  //         );
  //       } else if (userRole == 'advertiser') {
  //         Navigator.pushReplacementNamed(
  //             context, AdvertiserHomeScreen.routeName);
  //       } else {
  //         print('Unknown user role: $userRole');
  //       }
  //     }
  //   } 
  // }