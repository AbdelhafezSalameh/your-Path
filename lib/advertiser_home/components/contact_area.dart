import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_uni_services2/advertiser_home/components/advertisement_model.dart';
import 'package:student_uni_services2/advertiser_home/advertiserHomeScreen.dart';
import 'package:student_uni_services2/advertiser_home/components/detailes_house.dart';
import 'package:student_uni_services2/components/custom_dopDown.dart';
import 'package:student_uni_services2/components/custom_textField.dart';
import 'package:student_uni_services2/size_config.dart';

class ContactAndAreaScreen extends StatefulWidget {
  static String routeName = "/ContactAndAreaScreen";

  const ContactAndAreaScreen({Key? key}) : super(key: key);

  @override
  State<ContactAndAreaScreen> createState() => ContactAndAreaScreenState();
}

class ContactAndAreaScreenState extends State<ContactAndAreaScreen> {
  final TextEditingController areaController = TextEditingController();
  final TextEditingController contactAreaController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController websiteLinkController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> advertisement() async {
    try {
      await FirebaseFirestore.instance.collection('houses').add({
        'area': areaController.text,
        'contactArea': contactAreaController.text,
        'streetName': streetNameController.text,
        'houseNumber': houseNumberController.text,
        'websiteLink': websiteLinkController.text,
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Advertisement added successfully!'),
        ),
      );

      areaController.clear();
      contactAreaController.clear();
      streetNameController.clear();
      houseNumberController.clear();

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      // ignore: avoid_print
      print('Error uploading advertisement: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Fill out place of house information',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF297C74),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(20),
              horizontal: getProportionateScreenWidth(15)),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Select the house's city.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                CustomDropdownButton(
                  controller: areaController,
                  labelText: '',
                  prefixIcon: Icons.location_city,
                  options: const [
                    'Amman',
                    'Zarqa',
                    'Irbid',
                    'Ar Ramtha',
                    'Mafraq',
                    'Aqaba',
                    'Madaba',
                    'As-Salt',
                    'Jerash',
                    "Ma'an",
                    'Karak',
                    'Tafilah',
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                CustomTextField(
                  hintText: "Enter the house's area name.",
                  controller: contactAreaController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the area name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                CustomTextField(
                  hintText: "Enter the house's street name.",
                  controller: streetNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the street name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                CustomTextField(
                  hintText: "Enter the house number",
                  controller: houseNumberController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the house number";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                CustomTextField(
                  hintText: "Enter home Location link",
                  controller: websiteLinkController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the location link";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(10),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AdvertiserHomeScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text(
                        'Previous',
                        style: TextStyle(color: Colors.red[50]),
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(150),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AdvertisementModel_01 model = AdvertisementModel_01(
                            area: areaController.text,
                            contactArea: contactAreaController.text,
                            websiteLink: websiteLinkController.text,
                            houseNumber: houseNumberController.text,
                            streetName: streetNameController.text,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailesHouses(model: model),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF297C74),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.red[50]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
