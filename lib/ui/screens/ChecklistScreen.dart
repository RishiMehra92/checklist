import 'dart:io';
import 'package:checklist/util/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../util/AppText.dart';
import '../../util/showImagePicker.dart';
import '../../util/utils.dart';
import '../../viewmodel/ChecklistViewModel.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/latoButton.dart';

class ChecklistScreen extends GetView<ChecklistViewModel> {
  @override
  void initState() {
    controller.checkPermissions(); // Check permissions when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: const CustomAppBar(title: "Checklist"),
      body: Obx(() {
        return ListView.builder(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          itemCount: controller.checklistSize.value,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Checklist Item ${index + 1}",
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Obx(() {
                    // Show plus icon at the start and then media items
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // Horizontal scroll
                      child: Row(
                        children: [
                          // Plus icon to add new media
                          GestureDetector(
                            onTap: () async {
                              if(Platform.isAndroid){
                                // Check permissions before showing the image picker
                                bool cameraGranted = await controller
                                    .permissionService
                                    .requestCameraPermission();

                                if (cameraGranted) {
                                  showMediaTypePicker(
                                      context: context,
                                      controller: controller,
                                      index: index);
                                } else {
                                  showSnackbar(context, AppText.permissionDenied);
                                }
                              }else{
                                showMediaTypePicker(
                                    context: context,
                                    controller: controller,
                                    index: index);
                              }

                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.add,
                                  size: 40, color: Colors.black54),
                            ),
                          ),
                          // Display uploaded media horizontally
                          ...controller.checklistItems[index].mediaPaths
                              .map((media) {
                            return Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File(media),
                                        fit: BoxFit.fill,
                                        width: 100,
                                        height: 100,
                                      )),
                                  Positioned(
                                    top: 2,
                                    right: 2,
                                    child: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () =>
                                          controller.removeMedia(index, media),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 30),
          child: LatoButton(
            text: AppText.submit,
            backgroundColor:
                controller.isSubmitEnabled.value ? primarycolor : greyColor,
            color: white,
            onPressed: () {
              if (controller.isSubmitEnabled.value) {
                controller.saveToLocalStorage();
                showSnackbar(context, AppText.dataSave);
                Future.delayed(const Duration(seconds: 3), () {
                  Get.back();
                });
              } else {
                showSnackbar(context, AppText.selecteImages);
              }
            },
          ),
        );
      }),
    );
  }
}
