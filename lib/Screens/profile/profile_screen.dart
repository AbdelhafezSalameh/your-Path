import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:student_uni_services2/Firebase/FireBase_Storge.dart';
import 'package:student_uni_services2/Screens/sign_in/sign_in_screen.dart';
import 'package:student_uni_services2/generated/l10n.dart';
import 'package:student_uni_services2/size_config.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  late String fullName = '';
  late String major = '';
  late String? profileImageUrl;
  final FirebaseStorageService _storageService = FirebaseStorageService();

  @override
  void initState() {
    super.initState();
    fetchUserDataFromFirestore();
  }

  Future<void> fetchUserDataFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          setState(() {
            fullName = snapshot.get('fullName') ?? '';
            major = snapshot.get('major') ?? '';
            profileImageUrl = snapshot.get('profileImage') ?? '';

            if (profileImageUrl != null) {
              _image = File(profileImageUrl!);
            }
          });
        }
      } catch (e) {
        // ignore: avoid_print
        print('Error fetching user data from Firestore: $e');
      }
    }
  }

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      final user = FirebaseAuth.instance.currentUser;
      if (user != null && _image != null) {
        final imageUrl =
            await _storageService.uploadProfileImage(_image!, user.uid);

        if (imageUrl != null) {
          setState(() {
            profileImageUrl = imageUrl;
          });
        }
      }
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final ref = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            // ignore: prefer_interpolation_to_compose_strings
            .child(user.uid + '.jpg');

        await ref.putFile(imageFile);

        final imageUrl = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'profileImage': imageUrl,
        });

        setState(() {
          _image = imageFile;
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF297C74),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            Stack(
              children: [
                GestureDetector(
                  onTap: _getImage,
                  child: CircleAvatar(
                    radius: getProportionateScreenHeight(75),
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      fullName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      major,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ProfileMenu(
              text: S.of(context).profile_button_information,
              icon: "assets/icons/User Icon.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: S.of(context).profile_button_settings,
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: S.of(context).profile_button_logout,
              icon: "assets/icons/Log out.svg",
              press: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
    this.onTap,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              // ignore: deprecated_member_use
              color: const Color(0xff297C74),
              width: width * 0.06,
            ),
            const SizedBox(width: 20),
            Expanded(
              child:
                  Text(text, style: const TextStyle(color: Color(0xff297C74))),
            ),
            Container(
              height: height * 0.04,
              width: width * 0.08,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xff297C74)),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}