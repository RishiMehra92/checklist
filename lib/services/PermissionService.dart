import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  // Check if permission is granted, if not request it
  Future<bool> requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied || status.isRestricted) {
      // Request permission
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }

  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted) {
      // Request permission
      status = await Permission.camera.request();
    }
    return status.isGranted;
  }

  // Check if the permission is permanently denied
  Future<bool> isPermissionPermanentlyDenied(Permission permission) async {
    var status = await permission.status;
    return status.isPermanentlyDenied;
  }
}
