import 'package:flutter/material.dart';

class FormError extends StatelessWidget {
  final List<String?> errors;

  const FormError({Key? key, required this.errors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        errors.length,
        (index) => formErrorText(error: errors[index]!),
      ),
    );
  }

  Row formErrorText({required String error}) {
    return Row(
      children: [
        const Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
        const SizedBox(width: 10),
        Text(error),
      ],
    );
  }
}
