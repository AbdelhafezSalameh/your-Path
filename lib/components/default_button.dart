import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatefulWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.press,
    this.buttonStyle,
    this.textStyle, // Make it required
  }) : super(key: key);

  final String text;
  final VoidCallback press;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle; // Make it required

  @override
  // ignore: library_private_types_in_public_api
  _DefaultButtonState createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
        style: widget.buttonStyle ??
            TextButton.styleFrom(
              foregroundColor: isPressed ? Colors.red : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: kPrimaryColor,
            ),
        onPressed: () {
          setState(() {
            isPressed = !isPressed;
          });
          widget.press();
        },
        child: Text(
          widget.text,
          style: widget.textStyle,
        ),
      ),
    );
  }
}
