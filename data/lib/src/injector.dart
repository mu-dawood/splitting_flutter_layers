import 'package:domain/domain.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'repositries/image_picker_repo.dart';

typedef _FactoryFunc<T> = T Function();
typedef _FactoryRegisterCallback = void Function<T extends Object>(_FactoryFunc<T> factoryFunc, {String? instanceName});

class DataDependencies {
  static registerRepositories({required _FactoryRegisterCallback registerSingleton}) {
    registerSingleton<ImagePickerRepo>(
      () => ImagePickerRepoImpl(
        imagePicker: ImagePicker(),
        cameraPermission: Permission.camera,
        storagePermission: Permission.photos,
      ),
    );
  }
}
