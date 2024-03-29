import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  const AuthWrapper({Key? key, required this.selectedLanguageCode});
  final String selectedLanguageCode;

  static String routeName = "/AuthWrapper";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Lottie.asset('assets/videos/loading.json');
        } else if (snapshot.hasData) {
          // التسجيل ك طالب
          return FutureBuilder<String?>(
            future: getUserRole(FirebaseAuth.instance.currentUser?.uid ?? ""),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return Lottie.asset('assets/videos/loading.json');
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
