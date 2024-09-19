import 'package:flutter/material.dart';

import 'lato_text.dart';
import '../../util/appcolors.dart'; // Ensure to import your colors

class LatoButton extends StatelessWidget {
  final String text;
  final double? size;
  final double? height;
  final Color? color;
  final Color? backgroundColor;
  final String? fontFamily;
  final FontWeight? weight;
  final TextAlign? align;
  final VoidCallback onPressed;
  final double borderRadius;
  final bool isColorOpacity;
  final double shadowBlurRadius;

  const LatoButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.borderRadius = 8.0,
    this.color,
    this.height,
    this.backgroundColor,
    this.shadowBlurRadius = 10.0,
    this.size,
    this.align,
    this.isColorOpacity = false,
    this.fontFamily,
    this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height ?? 44,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor ?? primarycolor, // Set default color if null
          borderRadius: BorderRadius.circular(borderRadius),
          // Uncomment if you want to use shadow
          // boxShadow: [
          //   BoxShadow(
          //     color: primarycolor,
          //     offset: const Offset(-0.0, -0.0),
          //     blurRadius: shadowBlurRadius,
          //     spreadRadius: 0.0,
          //   ),
          // ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: LatoText(
              text: text,
              color: isColorOpacity ? color?.withOpacity(0.4) : color,
              size: size,
              fontFamily: "LatoRegular", // fontFamily,
              weight: weight,
            ),
          ),
        ),
      ),
    );
  }
}
