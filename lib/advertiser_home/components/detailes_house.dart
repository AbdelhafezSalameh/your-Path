import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_uni_services2/advertiser_home/components/advertisement_model.dart';
import 'package:student_uni_services2/components/custom_dopDown.dart';
import 'package:student_uni_services2/size_config.dart';
import 'contact_area.dart';
import 'title_description.dart';

class DetailesHouses extends StatefulWidget {
  static String routeName = "/DetailesHouses";
  final AdvertisementModel_01 model;

  const DetailesHouses({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<DetailesHouses> createState() => DetailesHousesState();
}

class DetailesHousesState extends State<DetailesHouses> {
  final TextEditingController floorController = TextEditingController();
  final TextEditingController residentsController = TextEditingController();
  final TextEditingController roomsController = TextEditingController();
  final TextEditingController bathroomsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> advertisement() async {
    try {
      await FirebaseFirestore.instance.collection('houses').add({
        'floor': int.tryParse(floorController.text) ?? 0,
        'rooms': int.tryParse(roomsController.text) ?? 0,
        'bathrooms': int.tryParse(bathroomsController.text) ?? 0,
        'residents': int.tryParse(residentsController.text) ?? 0,
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Advertisement added successfully!'),
        ),
      );

      floorController.clear();
      roomsController.clear();
      bathroomsController.clear();
      residentsController.clear();

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      // ignore: avoid_print
      print('Error uploading advertisement: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print(widget.model.area);
    // ignore: avoid_print
    print('heeey');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Enter Housing Details',
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Select the Floor.",
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
                controller: floorController,
                labelText: '',
                prefixIcon: Icons.house,
                options: const ['1', '2', '3', '4', '5', '6', '7+', 'roof'],
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              const Text(
                "Number of Rooms.",
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
                controller: roomsController,
                labelText: '',
                prefixIcon: Icons.home_max_outlined,
                options: const [
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7+',
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              const Text(
                "Number of BathRooms.",
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
                controller: bathroomsController,
                labelText: '',
                prefixIcon: Icons.bathroom_sharp,
                options: const [
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7+',
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              const Text(
                "Residents",
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
                controller: residentsController,
                labelText: '',
                prefixIcon: Icons.person_search,
                options: const [
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  '10+'
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Row(
                children: [
                  SizedBox(
                    width: getProportionateScreenWidth(10),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ContactAndAreaScreen.routeName);
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
                        AdvertisementModel_02 model = AdvertisementModel_02(
                          floor: int.tryParse(floorController.text) ?? 0,
                          rooms: int.tryParse(roomsController.text) ?? 0,
                          bathrooms:
                              int.tryParse(bathroomsController.text) ?? 0,
                          residents:
                              int.tryParse(residentsController.text) ?? 0,
                          advertisementModel_01: widget.model,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TitleAndDescriptionScreen(model: model),
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
    );
  }
}
