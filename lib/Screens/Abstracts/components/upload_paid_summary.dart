import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:student_uni_services2/Firebase/FireBase_Storge.dart';
import 'package:student_uni_services2/size_config.dart';

class UploadPaidSummaryScreen extends StatefulWidget {
  static String routeName = "/UploadPaidAbstract";

  const UploadPaidSummaryScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UploadPaidSummaryScreenState createState() =>
      _UploadPaidSummaryScreenState();
}

class _UploadPaidSummaryScreenState extends State<UploadPaidSummaryScreen> {
  late File _selectedFile = File('');
  final FirebaseStorageService _storageService = FirebaseStorageService();
  late String _selectedCollege;
  late String _selectedWalletType;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _priceController = TextEditingController();
    _selectedCollege = colleges[0];
    _selectedWalletType = walletTypes[0];
  }

  final List<String> colleges = [
    'IT',
    'LAW',
    'Business',
  ];
  final List<String> walletTypes = [
    'Orange Money',
    'Zain Cash',
    'Umniah Wallet',
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

  Future<void> _uploadPaidSummary() async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (_selectedFile.path.isNotEmpty) {
        String userId = "exampleUserId";
        String title = _titleController.text.trim();
        String description = _descriptionController.text.trim();
        String college = _selectedCollege;
        String walletType = _selectedWalletType;
        String phoneNumber = _phoneNumberController.text.trim();
        String price = _priceController.text.trim();

        String? downloadUrl = await _storageService.uploadPaidSummary(
          _selectedFile,
          userId,
          title: title,
          description: description,
          college: college,
          WalletType: walletType,
          phoneNumber: phoneNumber,
          price: price,
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
          _phoneNumberController.clear();
          _priceController.clear();
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
          right: getProportionateScreenWidth(15),
          left: getProportionateScreenWidth(15),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
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
              SizedBox(height: getProportionateScreenHeight(30)),
              DropdownButtonFormField<String>(
                value: _selectedWalletType,
                items: walletTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedWalletType = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Select Wallet Type',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(35)),
              SizedBox(
                height: getProportionateScreenWidth(50),
                width: getProportionateScreenWidth(330),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF297C74)),
                  ),
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
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10)),
                child: SizedBox(
                  height: getProportionateScreenWidth(50),
                  width: getProportionateScreenWidth(330),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF297C74)),
                    ),
                    onPressed: _isLoading ? null : _uploadPaidSummary,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
