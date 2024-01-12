import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_uni_services2/advertiser_home/components/advertisement_model.dart';
import 'package:student_uni_services2/advertiser_home/components/images_submit.dart';
import 'package:student_uni_services2/components/custom_textField.dart';
import 'package:student_uni_services2/size_config.dart';

class TitleAndDescriptionScreen extends StatefulWidget {
  static String routeName = "/TitleAndDescriptionScreen";
  final AdvertisementModel_02 model;

  const TitleAndDescriptionScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<TitleAndDescriptionScreen> createState() =>
      TitleAndDescriptionScreenState();
}

class TitleAndDescriptionScreenState extends State<TitleAndDescriptionScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController otherDetailsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> advertisement() async {
    try {
      await FirebaseFirestore.instance.collection('houses').add({
        'title': titleController.text,
        'otherDetails': otherDetailsController.text,
        'price': int.tryParse(priceController.text) ?? 0,
        'phoneNumber': phoneNumberController.text,
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Advertisement added successfully!'),
        ),
      );

      titleController.clear();
      otherDetailsController.clear();
      priceController.clear();
      phoneNumberController.clear();

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
          'Advertisement information',
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
            horizontal: getProportionateScreenWidth(15),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(250),
                  child: const Image(
                    image: AssetImage("assets/images/info ad.png"),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                CustomTextField(
                  controller: titleController,
                  hintText: 'Enter Title Advertisement',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                CustomTextField(
                  controller: otherDetailsController,
                  hintText: 'Enter Description Advertisement',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                CustomTextField(
                  controller: priceController,
                  hintText: 'Enter Price Advertisement',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                CustomTextField(
                  controller: phoneNumberController,
                  hintText: 'Enter a contact number',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(10),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
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
                          AdvertisementModel_03 model = AdvertisementModel_03(
                            price: int.tryParse(priceController.text) ?? 0,
                            title: titleController.text,
                            phoneNumber: phoneNumberController.text,
                            otherDetails: otherDetailsController.text,
                            advertisementModel_02: widget.model,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ImagesAndSubmitHouses(model: model),
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
