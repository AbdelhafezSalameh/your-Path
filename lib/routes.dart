import 'package:flutter/widgets.dart';
import 'package:student_uni_services2/Screens/exchange%20books/Book%20Exchange.dart';
import 'package:student_uni_services2/Screens/exchange%20books/components/Book%20Upload.dart';
import 'package:student_uni_services2/Screens/houses%20Screen/houses_Screen.dart';
import 'package:student_uni_services2/Screens/houses%20Screen/map_screen.dart';
import 'package:student_uni_services2/Screens/Abstracts/Abstract_Screen.dart';
import 'package:student_uni_services2/Screens/Abstracts/components/Abstracts_List.dart';
import 'package:student_uni_services2/Screens/otp/otp_screen.dart';
import 'package:student_uni_services2/Screens/university/TabBar.dart';
import 'package:student_uni_services2/Screens/Abstracts/components/Upload_Summary_Screen.dart';
import 'package:student_uni_services2/Screens/university/Ads/Ads.dart';
import 'package:student_uni_services2/Screens/university/Calander/Calander.dart';
import 'package:student_uni_services2/Screens/university/Events/Events.dart';
import 'package:student_uni_services2/Screens/university/News/News.dart';
import 'package:student_uni_services2/admin/homeScreen.dart';
import 'package:student_uni_services2/advertiser_home/advertiserHomeScreen.dart';
import 'package:student_uni_services2/advertiser_home/components/contact_area.dart';
import 'package:student_uni_services2/main/appmain/auth_wrap.dart';
import 'package:student_uni_services2/screens/complete_profile/complete_profile_screen.dart';
import 'package:student_uni_services2/screens/forgot_password/forgot_password_screen.dart';
import 'package:student_uni_services2/screens/home/home_screen.dart';
import 'package:student_uni_services2/screens/login_success/login_success_screen.dart';
import 'package:student_uni_services2/screens/sign_in/sign_in_screen.dart';
import 'package:student_uni_services2/screens/splash/splash_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  UploadSummaryScreen.routeName: (context) => const UploadSummaryScreen(),
  Tab_Bar.routeName: (context) => const Tab_Bar(),

  AdsScreen.routeName: (context) => const AdsScreen(),
  CalanderScreen.routeName: (context) => const CalanderScreen(),
  EventsScreen.routeName: (context) => const EventsScreen(),
  NewsScreen.routeName: (context) => const NewsScreen(),
  AbstractListScreen.routeName: (context) => const AbstractListScreen(),
  BookExchangeScreen.routeName: (context) => const BookExchangeScreen(),
  BookUploadScreen.routeName: (context) => const BookUploadScreen(),
  MapScreen.routeName: (context) => const MapScreen(),
  HomeScreenAdmin.routeName: (context) => const HomeScreenAdmin(),
  AuthWrapper.routeName: (context) => const AuthWrapper(),
  AdvertiserHomeScreen.routeName: (context) => const AdvertiserHomeScreen(),
  HousesScreen.routeName: (context) => const HousesScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),

  // TitleAndDescriptionScreen.routeName: (context) => TitleAndDescriptionScreen(),
  // DetailesHouses.routeName: (context) => DetailesHouses(),
  ContactAndAreaScreen.routeName: (context) => const ContactAndAreaScreen(),
  AbstractsScreen.routeName: (context) => const AbstractsScreen(),
  // ImagesAndSubmitHouses.routeName: (context) => ImagesAndSubmitHouses(),
};
