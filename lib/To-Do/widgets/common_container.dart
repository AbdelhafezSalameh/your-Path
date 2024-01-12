import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({
    super.key,
    this.child,
    this.height,
    this.width,
    this.color,
    this.borderRadius = 16,
    this.padding,
  });
  final Widget? child;
  final double? height;
  final double? width;
  final Color? color;
  final double borderRadius;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    const colors = Color(0xFF297C74);

    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
