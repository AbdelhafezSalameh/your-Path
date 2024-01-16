import 'package:flutter/material.dart';
import 'package:student_uni_services2/components/custom_dopDown.dart';
import 'package:student_uni_services2/size_config.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = "/settings";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController languageController = TextEditingController();
  String selectedLanguageCode = 'ar';

  void changeLanguage(String languageCode) {
    setState(() {
      selectedLanguageCode = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
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
          horizontal: getProportionateScreenWidth(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(250),
              child: const Image(
                image: AssetImage("assets/images/setting_screen.png"),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            CustomDropdownButton(
              controller: languageController,
              labelText: 'Choose The Language',
              labelTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
              hintText: 'Choose The Language',
              prefixIcon: Icons.language,
              options: const [
                'English',
                'Arabic',
                'Malaysian',
                'Afrikaans',
                'Spanish',
                'Hindi',
                'Portuguese',
                'Russian',
                'Japanese',
                "Lahnda",
              ],
              onChanged: (String selectedLanguage) {
                changeLanguage(selectedLanguage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
