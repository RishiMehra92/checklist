import 'package:checklist/ui/widgets/latoButton.dart';
import 'package:checklist/util/GlobalKeyManager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../util/AppText.dart';
import '../../util/GlobalTECManager.dart';
import '../../util/appcolors.dart';
import '../../util/utils.dart';
import '../../viewmodel/ChecklistViewModel.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/LatoTextInput.dart';

class ChecklistSizeScreen extends GetView<ChecklistViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar:
          const CustomAppBar(title: "Checklist Size", showBackButton: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 100),
        child: Card(
          color: white,
          elevation: 4, // Add elevation for a shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Minimize the column height
              children: [
                Form(
                  key: GlobalKeyManager.formKeyCheckList,
                  child: LatoTextInput(
                    controller: GlobalTECManager.checkListTEC,
                    hintText: AppText.checklistLabel,
                    hintcolor: greyColor,
                    color: black,
                    isNumeric: true,
                    maxLength: 3,
                    iconColor: greyColor,
                    isPassword: false,
                    size: 14,
                    weight: FontWeight.w400,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppText.enterchecklistLabel;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                LatoButton(
                  text: AppText.next,
                  color: white,
                  onPressed: () {
                    if (GlobalKeyManager.formKeyCheckList.currentState!
                        .validate()) {
                      int size = int.parse(GlobalTECManager.checkListTEC.text);
                      if (size > 0) {
                        controller.setChecklistSize(size);
                        Get.toNamed(Routes.ChecklistScreen);
                        GlobalTECManager.checkListTEC.clear();
                      } else {
                        showSnackbar(context, AppText.checklistSize);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
