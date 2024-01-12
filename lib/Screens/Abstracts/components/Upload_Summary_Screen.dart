import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:student_uni_services2/Firebase/FireBase_Storge.dart';
import 'package:student_uni_services2/size_config.dart';

class UploadSummaryScreen extends StatefulWidget {
  static String routeName = "/UploadAbstract";

  const UploadSummaryScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UploadSummaryScreenState createState() => _UploadSummaryScreenState();
}

class _UploadSummaryScreenState extends State<UploadSummaryScreen> {
  late File _selectedFile = File('');
  final FirebaseStorageService _storageService = FirebaseStorageService();
  late String _selectedCollege;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _selectedCollege = colleges[0];
  }

  final List<String> colleges = [
    'IT',
    'LAW',
    'Business',
  ];

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  bool _isLoading = false;

  Future<void> _uploadSummary() async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (_selectedFile.path.isNotEmpty) {
        String userId = "exampleUserId";
        String title = _titleController.text.trim();
        String description = _descriptionController.text.trim();
        String college = _selectedCollege;

        String? downloadUrl = await _storageService.uploadSummary(
          _selectedFile,
          userId,
          title: title,
          description: description,
          college: college,
        );

        if (downloadUrl != null) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Abstract uploaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          _titleController.clear();
          _descriptionController.clear();
          setState(() {
            _selectedFile = File('');
          });
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to upload Abstract.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No file selected.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading Abstract: $e'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: getProportionateScreenHeight(15),
            right: getProportionateScreenWidth(15),
            left: getProportionateScreenWidth(15),
            bottom: getProportionateScreenWidth(10)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                  height: getProportionateScreenHeight(180),
                  child: const Image(
                      image: AssetImage("assets/images/upload book.png"))),

              DropdownButtonFormField<String>(
                value: _selectedCollege,
                items: colleges.map((String college) {
                  return DropdownMenuItem<String>(
                    value: college,
                    child: Text(college),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedCollege = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Select College',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(35)),

              SizedBox(
                height: getProportionateScreenWidth(50),
                width: getProportionateScreenWidth(330),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF297C74))),
                  onPressed: _pickFile,
                  child: const Text(
                    'Pick Abstract File',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: getProportionateScreenHeight(16)),
              // ignore: unnecessary_null_comparison
              if (_selectedFile != null && _selectedFile.path.isNotEmpty)
                SizedBox(
                  height: getProportionateScreenHeight(300),
                  child: PDFView(
                    filePath: _selectedFile.path,
                    autoSpacing: false,
                    pageSnap: false,
                    pageFling: false,
                  ),
                ),
              SizedBox(
                height: getProportionateScreenWidth(50),
                width: getProportionateScreenWidth(330),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF297C74))),
                  onPressed: _isLoading ? null : _uploadSummary,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Upload Abstract',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
