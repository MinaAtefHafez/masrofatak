import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  Future<bool> checkPermission(Permission permission) async {
    PermissionStatus status = await permission.status;
    if (status.isGranted) return status.isGranted;
    status = await permission.request();
    return status.isGranted;
  }
}
