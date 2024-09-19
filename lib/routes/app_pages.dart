// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';

import '../ui/screens/ChecklistScreen.dart';
import '../ui/screens/ChecklistSizeScreen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.INITIAL, page: () => ChecklistSizeScreen()),
    GetPage(name: Routes.ChecklistScreen, page: () => ChecklistScreen()),
  ];

  static String getInitialRoute() {
    return Routes.INITIAL; // Make sure this matches the correct route constant
  }

  static List<GetPage> getRoutes() {
    return pages;
  }
}
