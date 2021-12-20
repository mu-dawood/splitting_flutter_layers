import 'package:domain/domain.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/file.dart';

class ImagePickerRepoImpl implements ImagePickerRepo {
  final Permission cameraPermission;
  final Permission storagePermission;
  final ImagePicker imagePicker;

  ImagePickerRepoImpl({
    required this.cameraPermission,
    required this.storagePermission,
    required this.imagePicker,
  });

  @override
  Future<bool> requestPermission(PermissionType type) async {
    var status = await (type == PermissionType.camera ? cameraPermission.status : storagePermission.status);
    if (status.isRestricted || status.isPermanentlyDenied) {
      return false;
    }
    if (status.isDenied) {
      status = await (type == PermissionType.camera ? cameraPermission.request() : storagePermission.request());
    }
    return !status.isDenied && !status.isRestricted && !status.isPermanentlyDenied;
  }

  @override
  Future<IFile?> pickImageFromCamera() async {
    var result = await imagePicker.pickImage(source: ImageSource.camera);
    if (result == null) return null;
    return FileModel(name: result.name, path: result.path);
  }

  @override
  Future<IFile?> pickImageFromGallery() async {
    var result = await imagePicker.pickImage(source: ImageSource.gallery);
    if (result == null) return null;
    return FileModel(name: result.name, path: result.path);
  }
}
