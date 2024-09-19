import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../util/appcolors.dart';
import 'lato_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final bool showIcon;
  final String? iconPath;
  final VoidCallback? iconOnPressed; // Optional callback for IconButton
  final bool showBackButton; // New property for back button visibility

  const CustomAppBar({
    Key? key,
    required this.title,
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.showIcon = false,
    this.iconPath,
    this.iconOnPressed,
    this.showBackButton = true, // Default to true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: backgroundColor ?? primarycolor,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primarycolor,
          statusBarIconBrightness:
              Brightness.light, // or Brightness.dark based on your app theme
        ),
        title: LatoText(
          text: title,
          size: 18,
          weight: FontWeight.w600,
          color: titleColor ?? white,
          align: TextAlign.center,
        ),
        leading: showBackButton // Conditionally render the back button
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back, // Default back icon
                  color: titleColor ?? white, // Icon color
                ),
                onPressed: () {
                  Get.back();
                },
              )
            : null // No leading widget if showBackButton is false
        );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
