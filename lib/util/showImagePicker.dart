import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../ui/widgets/lato_text.dart';
import '../viewmodel/ChecklistViewModel.dart';
import 'appcolors.dart';

void showMediaTypePicker({
  required BuildContext context,
  required ChecklistViewModel controller,
  required int index,
}) {
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
                // If user selects 'Image', show gallery/camera picker for images
                Navigator.of(context).pop();
                showImageOrVideoPicker(
                  context: context,
                  controller: controller,
                  index: index,
                  isVideo: false,
                );
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
                      Icon(Icons.image, color: Colors.white),
                      SizedBox(width: 10),
                      LatoText(
                        text: "Image",
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
                // If user selects 'Video', show gallery/camera picker for videos
                Navigator.of(context).pop();
                showImageOrVideoPicker(
                  context: context,
                  controller: controller,
                  index: index,
                  isVideo: true,
                );
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
                      Icon(Icons.videocam, color: Colors.white),
                      SizedBox(width: 10),
                      LatoText(
                        text: "Video",
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

void showImageOrVideoPicker({
  required BuildContext context,
  required ChecklistViewModel controller,
  required int index,
  required bool isVideo, // To differentiate between video or image selection
}) {
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
                // Pick from gallery
                controller.pickMedia(
                  isVideo ? ImageSource.gallery : ImageSource.gallery, // Image or Video
                  index,
                  isVideo: isVideo,
                );
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
                // Pick from camera
                controller.pickMedia(
                  isVideo ? ImageSource.camera : ImageSource.camera, // Image or Video
                  index,
                  isVideo: isVideo,
                );
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
