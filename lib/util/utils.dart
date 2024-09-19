// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

var storage = GetStorage();



void showSnackbar(BuildContext context, String msg) {
  final snackBar = SnackBar(
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding
      child: Text(msg),
    ),
    duration: const Duration(seconds: 2), // Duration to display the snackbar
    behavior: SnackBarBehavior.floating, // Optional: Makes the snackbar float
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
    ),
  );

  // Show the snackbar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
