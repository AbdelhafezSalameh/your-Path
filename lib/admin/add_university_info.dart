import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_uni_services2/Firebase/FireBase_Storge.dart';
import 'package:student_uni_services2/components/default_button.dart';
import 'package:student_uni_services2/size_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddUniversityInformation extends StatefulWidget {
  const AddUniversityInformation({super.key});

  @override
  State<AddUniversityInformation> createState() =>
      _AddUniversityInformationState();
}

class _AddUniversityInformationState extends State<AddUniversityInformation> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  List<String> adImages = [];

  void _addEvent() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        imageUrlController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('Events').add(
        {
          'title': titleController.text,
          'description': descriptionController.text,
          'date': Timestamp.now(),
          'image': imageUrlController.text,
        },
      );
      titleController.clear();
      descriptionController.clear();
      imageUrlController.clear();
      _showSuccessMessage('Event added successfully!');
    } else {
      _showErrorMessage('Please fill in all the fields.');
    }
  }

  void _addNews() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        imageUrlController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('News').add(
        {
          'title': titleController.text,
          'description': descriptionController.text,
          'date': Timestamp.now(),
          'image': imageUrlController.text,
        },
      );
      titleController.clear();
      descriptionController.clear();
      imageUrlController.clear();
      _showSuccessMessage('News added successfully!');
    } else {
      _showErrorMessage('Please fill in all the fields.');
    }
  }

  void _addAds() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        adImages.isNotEmpty) {
      FirebaseFirestore.instance.collection('Ads').add(
        {
          'title': titleController.text,
          'description': descriptionController.text,
          'images': adImages,
        },
      );
      titleController.clear();
      descriptionController.clear();
      adImages.clear();
      _showSuccessMessage('Ads added successfully!');
    } else {
      _showErrorMessage('Please fill in all the fields.');
    }
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _addCalander() {
    if (titleController.text.isNotEmpty &&
        startDateController.text.isNotEmpty &&
        endDateController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('Calander').add(
        {
          'title': titleController.text,
          'startDate': startDateController.text,
          'endDate': endDateController.text,
        },
      );
      titleController.clear();
      startDateController.clear();
      endDateController.clear();
      _showSuccessMessage('Calendar event added successfully!');
    } else {
      _showErrorMessage('Please fill in all the fields.');
    }
  }

  List<String> driverFCMToken = [
    "eQgY9TrtTsGTMAG66OKH7R:APA91bHNsLtWLoxTnpTLU2iSk29ynCUB1whePMGhbLX9ghZZ7Wd_GuNw-fkMMLFln11bPz9gcNNkTkDhL58sUt285TKLomMFsylCwEnTEpjNbk4WW4jckDzdycMLrWZkp8iA78pQ2xoK",
    "cn5GBikuRsq8X-vqUMuB6s:APA91bERprMyB7aFw-Tzs28WhhN7h4G9jYrKOttTo8Hs_ZA81MZRqmcOPC4z7NsGXsK6mSzbs6BAhsaM4Y2d5cL68LT-QbEaBTn87VtiP_OTR90jIrm-GM3UYXXX65V38EIYGp1WQ4AX",
    "dXmwGGnrQIeApAlVGC_s-h:APA91bEa13iMFwdEL3ciJ2FSKv_uRkfUYOu8P0BNREUC2Lzo1eaOxf_FZynBxqMc5_ZaPmphef4mY2v0ztKOXvYbRueCiflEINr3US8HJn4_ByjtZPMzw7BGgCfi88CZ2LS6AyMREpMg"
  ];

  Future<void> sendNotification(List<String> driverFCMToken) async {
    const String serverUrl = 'http://192.168.0.100:3000/send-notification';

    // final String serverUrl = 'http://192.168.67.236:3000';

    // ignore: unused_local_variable
    Map<String, dynamic> notificationData = {
      'title': 'New Ride Request',
      'body': 'A user wants to book a ride with you.',
      'driverFCMToken': driverFCMToken,
      // Add other custom data fields as needed
      'customKey': 'customValue',
    };

    try {
      final response = await http.post(
        Uri.parse(serverUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'driverFCMToken': driverFCMToken,
          'userMessage': 'Your notification message here',
        }),
      );

      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
                padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(200),
                  left: getProportionateScreenWidth(10),
                  right: getProportionateScreenWidth(10),
                ),
                child: Column(children: [
                  SizedBox(
                      height: getProportionateScreenHeight(250),
                      child: const Image(
                          image: AssetImage("assets/images/date.png"))),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Ads(context),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  News(context),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Events(context),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Calander(context),
                ]))));
  }

  // ignore: non_constant_identifier_names
  SizedBox Calander(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(340),
      height: getProportionateScreenHeight(50),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: const Color(0xff297C74),
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(16)),
                    child: Column(
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(16),
                        ),
                        TextField(
                          controller: startDateController,
                          decoration: const InputDecoration(
                            labelText: 'Start Date',
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2025),
                            );
                            if (pickedDate != null) {
                              startDateController.text =
                                  pickedDate.toLocal().toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(16),
                        ),
                        TextField(
                          controller: endDateController,
                          decoration: const InputDecoration(
                            labelText: 'End Date',
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2025),
                            );
                            if (pickedDate != null) {
                              endDateController.text =
                                  pickedDate.toLocal().toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(16),
                        ),
                        DefaultButton(
                          text: "Submit",
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          press: () {
                            _addCalander();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Text(
          "Add Calendar",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  SizedBox Events(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(340),
      height: getProportionateScreenHeight(50),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: const Color(0xff297C74),
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(16)),
                    child: Column(
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(labelText: 'Title'),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(16),
                        ),
                        TextField(
                          controller: descriptionController,
                          decoration:
                              const InputDecoration(labelText: 'Description'),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(16),
                        ),
                        TextField(
                          controller: imageUrlController,
                          decoration:
                              const InputDecoration(labelText: 'Image URL'),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(16),
                        ),
                        DefaultButton(
                          text: "Submit",
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          press: () {
                            sendNotification(driverFCMToken);
                            _addEvent();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Text(
          "Add Events",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  SizedBox News(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(340),
      height: getProportionateScreenHeight(50),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: const Color(0xff297C74),
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(16)),
                    child: Column(
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(labelText: 'Title'),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(16),
                        ),
                        TextField(
                          controller: descriptionController,
                          decoration:
                              const InputDecoration(labelText: 'Description'),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(16),
                        ),
                        TextField(
                          controller: imageUrlController,
                          decoration:
                              const InputDecoration(labelText: 'Image URL'),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(16),
                        ),
                        DefaultButton(
                          text: "Submit",
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          press: () {
                            _addNews();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Text(
          "Add News",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  SizedBox Ads(BuildContext context) {
    final FirebaseStorageService _storageService = FirebaseStorageService();

    return SizedBox(
      width: getProportionateScreenWidth(340),
      height: getProportionateScreenHeight(50),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: const Color(0xff297C74),
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(16)),
                    child: Column(
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(labelText: 'Title'),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(16),
                        ),
                        TextField(
                          controller: descriptionController,
                          decoration:
                              const InputDecoration(labelText: 'Description'),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(16),
                        ),
                        DefaultButton(
                          press: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(
                              source: ImageSource.gallery,
                            );

                            if (pickedFile != null) {
                              String? imageUrl =
                                  await _storageService.uploadAdsImage(
                                      File(pickedFile.path), "exampleUserId");

                              if (imageUrl != null) {
                                setState(() {
                                  adImages.add(imageUrl);
                                });
                              }
                            }
                          },
                          text: 'Choose Images',
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(16),
                        ),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: adImages.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      NetworkImage(adImages[index]),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(16),
                        ),
                        DefaultButton(
                          text: "Submit",
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          press: () {
                            _addAds();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Text(
          "Add Ads",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
