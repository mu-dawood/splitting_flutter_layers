import 'use_cases/camera_image.dart';
import 'use_cases/gallery_image.dart';

typedef _FactoryFunc<T> = T Function();
typedef _FactoryRegisterCallback = void Function<T extends Object>(_FactoryFunc<T> factoryFunc, {String? instanceName});

typedef GetInstance = T Function<T extends Object>({String? instanceName});

class DomainDependencies {
  static registerRepositories({
    required _FactoryRegisterCallback registerSingleton,
    required GetInstance getInstance,
  }) {
    registerSingleton(
      () => GalleryImage(
        repo: getInstance(),
        messenger: getInstance(),
        navigator: getInstance(),
      ),
    );
    registerSingleton(
      () => CameraImage(
        repo: getInstance(),
        messenger: getInstance(),
        navigator: getInstance(),
      ),
    );
  }
}
