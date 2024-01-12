import 'package:flutter/material.dart';

Widget buildProfileInfo(String label, dynamic value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$label: ",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          value ?? 'Not available',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    ),
  );
}
