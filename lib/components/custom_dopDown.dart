import 'package:flutter/material.dart';
import 'package:student_uni_services2/size_config.dart';

class CustomDropdownButton extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final List<String> options;

  const CustomDropdownButton({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.options,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String dropdownValue = 'choose';

  @override
  Widget build(BuildContext context) {
    String defaultValue = widget.options.isNotEmpty ? widget.options[0] : '';

    return DropdownButtonFormField<String>(
      value: widget.controller.text.isNotEmpty
          ? widget.controller.text
          : defaultValue,
      items: widget.options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          widget.controller.text = value!;
        });
      },
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: Icon(widget.prefixIcon),
        contentPadding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(16),
            horizontal: getProportionateScreenWidth(16)),
      ),
    );
  }
}
