import 'package:checklist/routes/app_pages.dart';
import 'package:checklist/util/AppText.dart';
import 'package:checklist/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import 'binding/AppBindings.dart';

Future<void> main() async {
  await GetStorage.init(); // Initialize local storage

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: AppText.appName,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      initialRoute: AppPages.getInitialRoute(),
      getPages: AppPages.getRoutes(),
    );
  }
}
