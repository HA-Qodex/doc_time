
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<void> requestPermission() async {
    await [Permission.microphone, Permission.camera].request();
  }

  Future<bool> hasPermission() async {
    return await Permission.microphone.isGranted &&
        await Permission.camera.isGranted;
  }
}