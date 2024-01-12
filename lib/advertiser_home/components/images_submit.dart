import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_uni_services2/Firebase/FireBase_Storge.dart';
import 'package:student_uni_services2/advertiser_home/advertiserHomeScreen.dart';
import 'package:student_uni_services2/advertiser_home/components/advertisement_model.dart';
import 'package:student_uni_services2/size_config.dart';

class ImagesAndSubmitHouses extends StatefulWidget {
  static String routeName = "/ImagesAndSubmitHouses";

  final AdvertisementModel_03 model;

  const ImagesAndSubmitHouses({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ImagesAndSubmitHousesState createState() => _ImagesAndSubmitHousesState();
}

class _ImagesAndSubmitHousesState extends State<ImagesAndSubmitHouses> {
  List<File> _images = [];
  bool _isLoading = false;

  final FirebaseStorageService _storageService = FirebaseStorageService();

  Future<void> advertisement() async {
    try {
      if (_images.isNotEmpty) {
        setState(() {
          _isLoading = true;
        });
        List<String?> imageUrls = [];

        for (var image in _images) {
          String? imageUrl =
              await _storageService.uploadHouseImage(image, "exampleUserId");
          imageUrls.add(imageUrl);
        }

        await FirebaseFirestore.instance.collection('houses').add({
          'imageUrls': imageUrls,
          'isAvailable': false,
          'area': widget.model.advertisementModel_02.advertisementModel_01.area,
          'contactArea': widget
              .model.advertisementModel_02.advertisementModel_01.contactArea,
          'streetName': widget
              .model.advertisementModel_02.advertisementModel_01.streetName,
          'houseNumber': widget
              .model.advertisementModel_02.advertisementModel_01.houseNumber,
          'websiteLink': widget
              .model.advertisementModel_02.advertisementModel_01.websiteLink,
          'floor': widget.model.advertisementModel_02.floor,
          'rooms': widget.model.advertisementModel_02.rooms,
          'bathrooms': widget.model.advertisementModel_02.bathrooms,
          'residents': widget.model.advertisementModel_02.residents,
          'title': widget.model.title,
          'otherDetails': widget.model.otherDetails,
          'price': widget.model.price,
          'phoneNumber': widget.model.phoneNumber,
        });

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Advertisement added successfully!'),
          ),
        );

        setState(() {
          _images.clear();
          _isLoading = false;
        });
      }
    } catch (e) {
      _isLoading = false;
      print('Error uploading advertisement: $e');
    }
  }

  Future<void> _getImages() async {
    List<XFile> images = await ImagePicker().pickMultiImage();

    if (images.isNotEmpty) {
      setState(() {
        _images = images.map((image) => File(image.path)).toList();
      });
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
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(20),
            horizontal: getProportionateScreenWidth(15)),
        child: Column(
          children: [
            const Text(
              "Welcome to the Image Upload and Submission screen.\nClick the 'Upload Image' button to\nadd a photo of your property, and\nthen press 'Submit' to complete the\nadvertisement process.",
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
              height: getProportionateScreenHeight(20),
            ),
            SizedBox(
              width: getProportionateScreenWidth(320),
              child: ElevatedButton(
                onPressed: () {
                  _getImages();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF297C74),
                ),
                child: const Text(
                  'Upload Image',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            _images.isNotEmpty
                ? SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(_images[index]),
                          ),
                        );
                      },
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(50),
                  bottom: getProportionateScreenHeight(15)),
              child: Row(
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
                    width: getProportionateScreenWidth(130),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      advertisement();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF297C74),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.red[50],
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(330),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AdvertiserHomeScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF297C74),
                ),
                child: const Text(
                  'Add More Advertise',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
