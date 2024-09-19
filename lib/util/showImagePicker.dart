import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../ui/widgets/lato_text.dart';
import '../viewmodel/ChecklistViewModel.dart';
import 'appcolors.dart';

void showImagePicker({required BuildContext context,required ChecklistViewModel controller,required int index}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => SafeArea(
      child: Container(
        height: 150,
        color: Colors.black.withOpacity(0.6),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InkWell(
              onTap: () {
                controller.pickMedia(ImageSource.gallery, index); // Pass the gallery source and index
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColor, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_library, color: Colors.white),
                      SizedBox(width: 10),
                      LatoText(
                        text: "Gallery",
                        color: white,
                        align: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                controller.pickMedia(ImageSource.camera, index); // Pass the camera source and index
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColor, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, color: Colors.white),
                      SizedBox(width: 10),
                      LatoText(
                        text: "Camera",
                        color: white,
                        align: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
