import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:student_uni_services2/generated/l10n.dart';
import 'package:student_uni_services2/size_config.dart';

class BookUploadScreen extends StatefulWidget {
  static String routeName = "/BookUpload";

  const BookUploadScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookUploadScreenState createState() => _BookUploadScreenState();
}

class _BookUploadScreenState extends State<BookUploadScreen> {
  TextEditingController titleController = TextEditingController();
  String selectedCategory = 'IT';
  File? _image;
  bool _isLoading = false;

  Future<void> _uploadBook() async {
    try {
      setState(() {
        _isLoading = true;
      });
      String title = titleController.text.trim();

      if (_image != null) {
        String imageUrl = await _uploadImageToFirebase(_image!);

        await FirebaseFirestore.instance.collection('books').add({
          'title': title,
          'category': selectedCategory,
          'imageUrl': imageUrl,
          'isApproved': false,
        });

        titleController.clear();
        setState(() {
          _image = null;
          selectedCategory = 'IT';
          _isLoading = false;
        });

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Book uploaded successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading book: $e'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String> _uploadImageToFirebase(File imageFile) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('book_images/${DateTime.now()}.jpg');

      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  List<String> bookCategories = [
    'IT',
    'Business',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload Book',
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                  height: getProportionateScreenHeight(220),
                  child: const Image(
                      image: AssetImage("assets/images/upload book.png"))),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    labelText: S.of(context).exchange_book_upload_hint_title),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              Text(
                S.of(context).exchange_book_upload_text,
                style: const TextStyle(
                    color: Color(0xFF297C74), fontWeight: FontWeight.bold),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: '',
                ),
                items: bookCategories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              _image != null
                  ? Image.file(
                      _image!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(),
              SizedBox(height: getProportionateScreenWidth(30)),
              SizedBox(
                height: getProportionateScreenWidth(50),
                width: getProportionateScreenWidth(330),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF297C74)),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 16, // Adjust the font size as needed
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onPressed: _getImage,
                  child: Text(
                    S.of(context).exchange_book_upload_choose_button,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(30)),
              SizedBox(
                height: getProportionateScreenWidth(50),
                width: getProportionateScreenWidth(330),
                child: ElevatedButton(
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF297C74))),
                  onPressed: _isLoading ? null : _uploadBook,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(S.of(context).exchange_book_upload_submit_button,
                          style: const TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
