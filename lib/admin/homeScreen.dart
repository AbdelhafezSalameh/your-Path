import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_uni_services2/Screens/splash/splash_screen.dart';
import 'package:student_uni_services2/admin/TabBar.dart';
import 'package:student_uni_services2/components/default_button.dart';
import 'package:student_uni_services2/size_config.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({super.key});

  static String routeName = "/HomeScreenAdmin";

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
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
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(20),
                horizontal: getProportionateScreenWidth(13)),
            child: const Text(
              "Here, you can manage content and settings to enhance user experience.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(25),
          ),
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.694,
                decoration: const BoxDecoration(
                    color: Color(0xFF297C74),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: SizedBox(
                        height: getProportionateScreenHeight(280),
                        child: const Image(
                            image: AssetImage("assets/images/admin.png"))),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(15)),
                    child: DefaultButton(
                      text: "Mange Application",
                      textStyle: const TextStyle(
                          color: Color(0xFF297C74),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Admin_Tab_Bar(),
                          ),
                        );
                      },
                      buttonStyle: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(15)),
                    child: DefaultButton(
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
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
