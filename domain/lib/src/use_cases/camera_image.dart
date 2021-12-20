import '../entities/enums.dart';
import '../entities/file.dart';
import '../entities/results.dart';
import '../repositries/image_picker_repo.dart';
import '../services/messenger.dart';
import '../services/navigator.dart';

class CameraImage {
  final IMessenger messenger;
  final ImagePickerRepo repo;
  final INavigator navigator;

  CameraImage({
    required this.messenger,
    required this.navigator,
    required this.repo,
  });

  AsyncUseCaseResult<IFile?> call() {
    return AsyncUseCaseResult(
      action: () async {
        var hasPermission = await repo.requestPermission(PermissionType.camera);
        if (!hasPermission) {
          hasPermission = await navigator.openPermissionDialog(PermissionType.camera);
        }
        if (!hasPermission) {
          throw Failure(FailureType.cameraPermission);
        }
        return await repo.pickImageFromCamera();
      },
      messenger: messenger,
    );
  }
}
