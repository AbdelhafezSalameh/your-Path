import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_uni_services2/Screens/splash/splash_screen.dart';
import 'package:student_uni_services2/advertiser_home/components/contact_area.dart';
import 'package:student_uni_services2/components/default_button.dart';
import 'package:student_uni_services2/size_config.dart';

class AdvertiserHomeScreen extends StatefulWidget {
  static String routeName = "/AdvertiserHome";
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const AdvertiserHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdvertiserHomeScreen> createState() => _AdvertiserHomeScreenState();
}

class _AdvertiserHomeScreenState extends State<AdvertiserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Welcome, Advertiser!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF297C74),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(20),
            horizontal: getProportionateScreenWidth(15)),
        child: Column(
          children: [
            const Text(
              "Here you can publish your\nadvertisement for your home for\nrent easily and conveniently.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            SizedBox(
                height: getProportionateScreenHeight(250),
                child:
                    const Image(image: AssetImage("assets/images/adv ad.png"))),
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            const Text(
              "Start adding your house details and\nlet us do the rest.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            DefaultButton(
              text: "Create Advertise",
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactAndAreaScreen(),
                  ),
                );
              },
              buttonStyle: TextButton.styleFrom(
                backgroundColor: const Color(0xFF297C74),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            DefaultButton(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              text: "Logout",
              press: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, SplashScreen.routeName);
              },
              buttonStyle: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
