import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../services/PermissionService.dart';
import '../data/ChecklistItem.dart';
import '../util/AppText.dart';
import '../util/utils.dart';

class ChecklistViewModel extends GetxController {
  var checklistSize = 0.obs;
  var checklistItems = <ChecklistItem>[].obs;
  var isSubmitEnabled = false.obs;

  final ImagePicker _picker = ImagePicker();
  final PermissionService permissionService = PermissionService(); // Instance of permission handler

  @override
  void onInit() {
    super.onInit();
    loadFromLocalStorage(); // Load from local storage if available
  }

  // Set the checklist size from the first screen
  void setChecklistSize(int size) {
    checklistSize.value = size;
    checklistItems.value =
        List.generate(size, (_) => ChecklistItem(mediaPaths: []));
    checkSubmitStatus(); // Check if submit should be enabled after setting size
  }

  // Add media (image/video) to a checklist item
  void addMedia(int index, String mediaPath) {
    if (checklistItems[index].mediaPaths.length < 10) {
      checklistItems[index].mediaPaths.add(mediaPath);
      checklistItems
          .refresh(); // Ensure the UI gets updated after media is added
    }
    checkSubmitStatus();
    saveToLocalStorage(); // Save the updated checklist state
  }

  // Remove media from a checklist item
  void removeMedia(int index, String mediaPath) {
    checklistItems[index].mediaPaths.remove(mediaPath);
    checklistItems
        .refresh(); // Ensure the UI gets updated after media is removed
    checkSubmitStatus();
    saveToLocalStorage(); // Save the updated checklist state
  }

  // Check if the submit button should be enabled
  void checkSubmitStatus() {
    isSubmitEnabled.value = checklistItems.every((item) => item.isValid());
  }

  // Save the checklist to local storage
  void saveToLocalStorage() {
    final data = checklistItems.map((item) => item.toMap()).toList();
    storage.write('checklist_items', data);
  }

  // Load the checklist from local storage
  void loadFromLocalStorage() {
    List<dynamic>? savedData = storage.read('checklist_items');
    if (savedData != null) {
      checklistItems.value =
          savedData.map((data) => ChecklistItem.fromMap(data)).toList();
      checkSubmitStatus(); // Ensure submit status is checked after loading data
    }
  }

  // Clear the local storage
  void clearLocalStorage() {
    storage.remove('checklist_items');
  }

  // Pick media for a given checklist index, supporting both image and video
  Future<void> pickMedia(ImageSource source, int index, {bool isVideo = false}) async {
    // Request storage permission before opening gallery or camera
    bool isStorageGranted = await permissionService.requestStoragePermission();
    bool isCameraGranted = await permissionService.requestCameraPermission();

    if (isStorageGranted || isCameraGranted) {
      XFile? pickedFile;

      // Pick video or image based on the media type
      if (isVideo) {
        pickedFile = await _picker.pickVideo(source: source);
      } else {
        pickedFile = await _picker.pickImage(source: source);
      }

      if (pickedFile != null) {
        addMedia(index, pickedFile.path); // Add the picked media to the checklist
      }
    } else {
      Get.snackbar(
        'Permission Denied',
        'Storage or Camera permission is required to upload images/videos.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void checkPermissions() async {
    // Request storage and camera permissions
    bool cameraGranted = await permissionService.requestCameraPermission();
    bool storageGranted = await permissionService.requestStoragePermission();

    if (!cameraGranted || !storageGranted) {
      // Show snackbar or alert if permissions are not granted
      showSnackbar(Get.context!, AppText.permissionDenied);
    }
  }
}
