import '../entities/enums.dart';
import '../entities/file.dart';

abstract class ImagePickerRepo {
  Future<bool> requestPermission(PermissionType type);
  Future<IFile?> pickImageFromCamera();
  Future<IFile?> pickImageFromGallery();
}
