import 'dart:io' if (dart.library.html) '';

import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerBloc extends Cubit<ImagePickerBlocState> with ImagePickerBlocBase {
  @override
  final GetInstance getInstance;
  ImagePickerBloc(this.getInstance) : super(IntialState());
}

class ImagePickerScreen extends StatelessWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<ImagePickerBloc>();
    var state = bloc.state;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state is PickedState) ...[
              _imageName(state.file),
              const SizedBox(height: 20),
              _image(state.file),
            ],
            ElevatedButton(
              onPressed: state is Loading ? null : bloc.pickImageFromGallery,
              child: Text(state is Loading ? 'Loading ...' : 'Pick image from Gallery'),
            ),
            ElevatedButton(
              onPressed: state is Loading ? null : bloc.pickImageFromCamera,
              child: Text(state is Loading ? 'Loading ...' : 'Pick image from camera'),
            )
          ],
        ),
      ),
    );
  }

  Widget _image(IFile file) {
    if (kIsWeb) {
      return Image.network(file.path);
    } else {
      return Image.file(File(file.path));
    }
  }

  Widget _imageName(IFile file) {
    return Text(file.name);
  }
}

class PermissionDialog extends StatelessWidget {
  final PermissionType type;
  const PermissionDialog({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Permission denied',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20),
          Text(
            'Sorry your permission to ${PermissionType.camera.name} is denied',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Open application settings
            },
            child: const Text('Open settings'),
          )
        ],
      ),
    );
  }
}
