import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../util/appcolors.dart';

class LatoTextInput extends StatefulWidget {
  final String? iconPath;
  final String hintText;
  final bool isPassword;
  final bool isNumeric; // New boolean flag for numeric input
  final double? size;
  final double? borderRadius;
  final Color? color;
  final Color? hintcolor;
  final Color? iconColor;
  final String? fontFamily;
  final FontWeight? weight;
  final TextAlign? align;
  final double? height;
  final int? maxLine;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final TextEditingController? controller;

  const LatoTextInput({
    Key? key,
    this.iconPath,
    required this.hintText,
    this.isPassword = false,
    this.isNumeric = false, // Default is false for non-numeric input
    this.size,
    this.color,
    this.hintcolor,
    this.validator,
    this.borderRadius,
    this.fontFamily,
    this.align,
    this.textCapitalization = TextCapitalization.sentences,
    this.maxLength,
    this.iconColor,
    this.weight,
    this.height,
    this.maxLine,
    this.controller,
  }) : super(key: key);

  @override
  _LatoTextInputState createState() => _LatoTextInputState();
}

class _LatoTextInputState extends State<LatoTextInput> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: widget.controller,
        keyboardType:
        widget.isNumeric ? TextInputType.number : TextInputType.text, // Set keyboard type based on isNumeric
        inputFormatters: widget.isNumeric
            ? [FilteringTextInputFormatter.digitsOnly] // Restrict input to digits only if isNumeric is true
            : [],
        decoration: InputDecoration(
          // Show prefixIcon only if iconPath is not null
          prefixIcon: widget.iconPath != null
              ? Transform.scale(
            scale: 0.5, // Adjust the scale factor as needed
            child: SvgPicture.asset(
              widget.iconPath!,
              color: widget.iconColor,
            ),
          )
              : null,
          prefixIconColor: widget.iconColor,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontFamily: "LatoRegular", // widget.fontFamily,
            fontSize: widget.size,
            color: widget.hintcolor,
            fontWeight: widget.weight,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: greyColor,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          )
              : null,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primarycolor),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,horizontal: 12), // Adjust vertical padding as needed
        ),
        obscureText: widget.isPassword && !_isPasswordVisible,
        style: TextStyle(
          fontFamily: "LatoRegular", // widget.fontFamily,
          fontSize: widget.size,
          color: widget.color,
          fontWeight: widget.weight,
        ),
        validator: (value) {
          if (widget.validator != null) {
            return widget.validator!(value);
          }
          if (widget.maxLength != null &&
              value != null &&
              value.length > widget.maxLength!) {
            return 'Max length is ${widget.maxLength} characters';
          }
          return null;
        },
        textCapitalization: widget.textCapitalization,
      ),
    );
  }
}
