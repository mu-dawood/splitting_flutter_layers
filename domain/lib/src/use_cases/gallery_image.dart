import '../entities/enums.dart';
import '../entities/file.dart';
import '../entities/results.dart';
import '../repositries/image_picker_repo.dart';
import '../services/messenger.dart';
import '../services/navigator.dart';

class GalleryImage {
  final IMessenger messenger;
  final ImagePickerRepo repo;
  final INavigator navigator;

  GalleryImage({
    required this.messenger,
    required this.navigator,
    required this.repo,
  });

  AsyncUseCaseResult<IFile?> call() {
    return AsyncUseCaseResult(
      action: () async {
        var hasPermission = await repo.requestPermission(PermissionType.storage);
        if (!hasPermission) {
          hasPermission = await navigator.openPermissionDialog(PermissionType.storage);
        }
        if (!hasPermission) {
          throw Failure(FailureType.storagePermission);
        }
        return await repo.pickImageFromGallery();
      },
      messenger: messenger,
    );
  }
}
