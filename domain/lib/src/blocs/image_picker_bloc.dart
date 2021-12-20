import '../entities/file.dart';
import '../use_cases/camera_image.dart';
import '../use_cases/gallery_image.dart';
import 'base_bloc.dart';

abstract class ImagePickerBlocState {}

class IntialState implements ImagePickerBlocState {
  IntialState();
}

class Loading implements ImagePickerBlocState {
  Loading();
}

class PickedState implements ImagePickerBlocState {
  final IFile file;
  PickedState(this.file);
}

abstract class ImagePickerBlocBase implements AppBaseBloc<ImagePickerBlocState> {
  Future pickImageFromGallery() async {
    emit(Loading());
    GalleryImage galleryImage = getInstance();

    var file = await galleryImage().handleOr();
    if (file == null) {
      emit(IntialState());
    } else {
      emit(PickedState(file));
    }
  }

  Future pickImageFromCamera() async {
    emit(Loading());
    CameraImage cameraImage = getInstance();
    var file = await cameraImage().handleOr();
    if (file == null) {
      emit(IntialState());
    } else {
      emit(PickedState(file));
    }
  }
}
