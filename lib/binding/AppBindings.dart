import 'package:get/get.dart';

import '../viewmodel/ChecklistViewModel.dart';


class AppBindings extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut<ChecklistViewModel>(() => ChecklistViewModel(), fenix: true);

  }
}
