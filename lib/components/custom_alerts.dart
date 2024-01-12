import 'package:flutter/material.dart';
import 'package:student_uni_services2/size_config.dart';

class CustomConfirmationAlert extends StatelessWidget {
  final String title;
  final String bookName;
  final String location;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const CustomConfirmationAlert({
    required this.title,
    required this.bookName,
    required this.location,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Text(title),
        content: SizedBox(
          height: getProportionateScreenHeight(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Book Name: $bookName",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "Located in: $location",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel",
                style: TextStyle(
                    color: Color(0xFF297C74), fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: getProportionateScreenWidth(55)),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
